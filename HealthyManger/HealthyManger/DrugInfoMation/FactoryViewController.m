//
//  FactoryViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FactoryViewController.h"
#import "FactoryShowViewController.h"
#import "FactoryLoctionViewController.h"

#import "FactoryProvinceModel.h"
#import "FactoryListModel.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "FactoryListInfoCell.h"
#import "porvinceCellView.h"

@interface FactoryViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)NSMutableArray *modelArray;
@property (nonatomic,assign)NSString *row;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)FactoryListModel *model;

@property (nonatomic,strong)NSMutableArray *provinceModelArray;

@property (nonatomic,assign)CGFloat height;

@property (nonatomic,copy)NSString *porvince;
@end

@implementation FactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _provinceModelArray =[NSMutableArray array];
    _modelArray =[NSMutableArray array];
    
    _page = 1;
    _row = @"20";
    _ID = @"0";
    [self getHttpData];
    
    //[self getHTTPData];
    
    [self createUI];
    
    [self createTableView];
    
    [self reloadPlistFileData];
    
    [self createPorvinceView];
    
}

-(void)createUI
{
    CGFloat widht = SCRREN_MAIN_SIZE.width / 2.0;
    
    UIView *leftView =[[UIView alloc]initWithFrame:CGRectMake(0,64.0,widht,40.0)];
    leftView.backgroundColor =[UIColor colorWithRed:0.184 green:0.572 blue:0.692 alpha:1.000];
    
    UITextField *textField =[[UITextField alloc]initWithFrame:CGRectMake(10.0,5.0,widht-20.0,30.0)];
    textField.borderStyle =UITextBorderStyleRoundedRect;
    textField.returnKeyType = UIReturnKeySearch;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.placeholder =@"输入省份名称";
    textField.delegate = self;
    textField.tag = 2000;
    
    [leftView addSubview:textField];

    UIButton *rightView =[UIButton buttonWithType:UIButtonTypeCustom];
    rightView.frame = CGRectMake(leftView.frame.size.width,leftView.frame.origin.y,widht, 40.0);
    rightView.backgroundColor =[UIColor colorWithRed:0.292 green:0.500 blue:0.169 alpha:1.000];
    [rightView setImage:[UIImage imageNamed:@"tab6_2"] forState:UIControlStateNormal];
    [rightView setTitle:@"附近药企" forState:UIControlStateNormal];
    [rightView addTarget:self action:@selector(PushFactoryLoction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(leftView.frame.origin.x,100.0,widht,4.0)];
    lineView.backgroundColor =[UIColor redColor];
    lineView.tag = 1000;
    
    
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:lineView];
    
}

-(void)reloadPlistFileData
{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"FactoryProvince.plist" ofType:nil];
    //NSLog(@"%@",path);
    NSArray *provinceArray =[NSArray arrayWithContentsOfFile:path];
    //NSLog(@"%@",provinceArray);
    for (NSDictionary *dic in provinceArray)
    {
        FactoryProvinceModel *model =[[FactoryProvinceModel alloc]mj_setKeyValues:dic];
        [_provinceModelArray addObject:model];
        //NSLog(@"%@",model.province);
    }
}

-(void)getHTTPData
{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"FactoryProvince.plist" ofType:nil];
    NSLog(@"%@",path);
    
    NSString *url =[NSString stringWithFormat:TGAPI_FACTORY_PROVINCE];
    self.httpUrl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *provinceArray =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [provinceArray writeToFile:path atomically:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)getHttpData
{
    
    
    NSString *url =[NSString stringWithFormat:TGAPI_FACTORY_LIST,_ID,(long)_page,_row];
    self.httpUrl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"测试省份%@",self.httpUrl);
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",operation.responseString);
        _model =[[FactoryListModel alloc]mj_setKeyValues:operation.responseString];
        
        [_modelArray addObjectsFromArray:_model.tngou];
        [_table reloadData];
        
        [_table.header endRefreshing];
        [_table.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [_table.header endRefreshing];
        [_table.footer endRefreshing];
    }];
}


-(void)PushFactoryLoction:(UIButton *)sender
{
    UITextField *text =(UITextField *)[self.view viewWithTag:2000];
    [text resignFirstResponder];
    UIView *lineView = (UIView *)[self.view viewWithTag:1000];
    CGRect frame = lineView.frame;
    frame = CGRectMake(frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        lineView.frame = frame;
    }];
    
    FactoryLoctionViewController *factoryLoctionView =[[FactoryLoctionViewController alloc]init];
    
    factoryLoctionView.navigationItem.title = @"周边药厂";
    [self.navigationController pushViewController:factoryLoctionView animated:YES];

}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIView *lineView = (UIView *)[self.view viewWithTag:1000];
    CGRect frame = lineView.frame;
    frame = CGRectMake(0,frame.origin.y, frame.size.width, frame.size.height);
    
    UIView *porvince = (id)[self.view viewWithTag:4000];
    CGRect frame1 = porvince.frame;
    frame1 = CGRectMake(0, frame1.origin.y, frame1.size.width, frame1.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        lineView.frame = frame;
        porvince.frame = frame1;
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    UIView *porvince = (id)[self.view viewWithTag:4000];
    CGRect frame1 = porvince.frame;
    frame1 = CGRectMake(-frame1.size.width, frame1.origin.y, frame1.size.width, frame1.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        porvince.frame = frame1;
    }];
    
    [_modelArray removeAllObjects];
    [self getHttpData];
    
    textField.text = nil;
    

    
    return YES;
}

-(void)createPorvinceView
{
    CGFloat widht = SCRREN_MAIN_SIZE.width / 2.0;
    
    porvinceCellView *porvince =[[porvinceCellView alloc]initWithFrame:CGRectMake(-widht,110.0,widht,300.0)];
    //porvince.backgroundColor =[UIColor redColor];
    
    porvince.tag = 4000;
    
    [porvince createTableViewWithArray:_provinceModelArray];
    
    [self.view addSubview:porvince];
    
    UIView *porvinc = (id)[self.view viewWithTag:4000];
    CGRect frame1 = porvince.frame;
    frame1 = CGRectMake(-frame1.size.width, frame1.origin.y, frame1.size.width, frame1.size.height);
    
    porvince.slectPorvice = ^(NSString *porviceName,NSNumber *ID){
        UITextField *text =(UITextField *)[self.view viewWithTag:2000];
        text.text = porviceName;
        _ID = [ID stringValue];
        porvinc.frame = frame1;
    };
}

-(void)createTableView
{
    _table =[[UITableView alloc]initWithFrame:CGRectMake(0,104.0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    //_table.bounces = NO;
    _table.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    UINib *nib = [UINib nibWithNibName:@"FactoryListInfoCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"FactoryListInfoCell"];
    
    _table.rowHeight = UITableViewAutomaticDimension;
    
    __block id weakSelf = self;
    _table.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_modelArray removeAllObjects];
        //_row = 20;
        _page = 1;
        [weakSelf getHttpData];
     }];
    
    _table.footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        //_row += 20;
        _page ++;
        [weakSelf getHttpData];
    }];
    
    [self.view addSubview:_table];
    [_table.header beginRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FactoryListInfoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FactoryListInfoCell"];
    if (!cell) {
        cell =[[FactoryListInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FactoryListInfoCell"];
    }
    if (_modelArray.count)
    {
        cell.model = _modelArray[indexPath.row];
    }
    
    _height = cell.cellHeight;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 150.0;
    return _height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FactoryListInfoModel *model = _modelArray[indexPath.row];
    FactoryShowViewController *showView =[[FactoryShowViewController alloc] init];
    showView.url = model.url;
    showView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showView animated:YES];
    showView.hidesBottomBarWhenPushed = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
