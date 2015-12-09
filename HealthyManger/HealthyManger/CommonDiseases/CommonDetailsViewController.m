//
//  CommonDetailsViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommonDetailsViewController.h"
#import "CommonSearchDetailsViewController.h"


#import "AFNetworking.h"
#import "MJExtension.h"

#import "CommonDetailsModel.h"

#import "ComonDetailsTableViewCell.h"

@interface CommonDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,ComonDetailsTableViewCellDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)CommonDetailsModel *detailsModel;
@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong)ComonDetailsTableViewCell *cell;

@property (nonatomic,assign)CGFloat cellHeight;
@end

@implementation CommonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self getHttpData];
    
    //[self createTableView];
}

-(void)getHttpData
{
    NSInteger page = 1;
    NSString *key = @"";
    NSString *url =[NSString stringWithFormat:API_URL_COMMON_DISEASES_SEARCH,key,page,self.currentDate,_subTypeID,_typeId];
 
    self.httpUrl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    __block id weakSelf=self;
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"%@",operation.responseString);
        _detailsModel =[[CommonDetailsModel alloc]mj_setKeyValues:operation.responseString];
        //NSLog(@"%@",_detailsModel.contentlist);
        if (_detailsModel.contentlist.count < 1)
        {
            [weakSelf createAlertView];
        }
        else
        {
            [weakSelf createTableView];
        }
        [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void)createAlertView
{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"此样目下无数据" delegate:self cancelButtonTitle:@"返回上一页" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)createTableView
{
    _table =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRREN_MAIN_SIZE.width, SCRREN_MAIN_SIZE.height) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    
    UINib *nib =[UINib nibWithNibName:@"ComonDetailsTableViewCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"ComonDetailsTableViewCell"];
    _table.bounces = NO;
    _table.showsVerticalScrollIndicator = NO;
     _table.backgroundColor =[UIColor colorWithWhite:0.502 alpha:0.780];
    _table.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_table];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _detailsModel.contentlist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell =[tableView dequeueReusableCellWithIdentifier:@"ComonDetailsTableViewCell"];
    if (!_cell)
    {
        _cell = [[ComonDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ComonDetailsTableViewCell"];
    }
    
    _cell.list = _detailsModel.contentlist[indexPath.section];
    
    NSMutableString *newStr =[self dealStrDataWithString:_cell.list.summary];
    //NSLog(@"%@",newStr);
    
    CGRect size= [newStr boundingRectWithSize:CGSizeMake(_cell.summaryLab.bounds.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    
    _cell.summaryLab.frame = CGRectMake(_cell.summaryLab.frame.origin.x, _cell.summaryLab.frame.origin.y, _cell.summaryLab.frame.size.width, size.size.height +20.0);
    _cell.summaryLab.font =[UIFont systemFontOfSize:15.0];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     _cell.summaryLab.text = newStr;
    
    
    _cell.delegate = self;
    
    _cellHeight = _cell.summaryLab.frame.origin.y + _cell.summaryLab.frame.size.height;
    NSLog(@"=======:%f",_cellHeight);
    return _cell;
}

-(NSMutableString *)dealStrDataWithString:(NSString *)str
{
  
    
    NSMutableString *newStr =[NSMutableString stringWithString:str];
    NSString *replace = @"";
    NSRange subStr1 =[newStr rangeOfString:@"<p>"];
    while (subStr1.location != NSNotFound) {
        [newStr replaceCharactersInRange:subStr1 withString:replace];
        subStr1 =[newStr rangeOfString:@"<p>"];
    }
    
    NSRange subStr2 =[newStr rangeOfString:@"</p>"];
    while (subStr2.location != NSNotFound)
    {
        [newStr replaceCharactersInRange:subStr2 withString:replace];
        subStr2 =[newStr rangeOfString:@"</p>"];
    }
    
    NSRange subStr3 =[newStr rangeOfString:@"</P><P>"];
    while (subStr3.location != NSNotFound)
    {
        [newStr replaceCharactersInRange:subStr3 withString:replace];
        subStr3 =[newStr rangeOfString:@"</P><P>"];
        
    }
    
    NSRange subStr4 =[newStr rangeOfString:@"</P> <P>"];
    while (subStr4.location != NSNotFound)
    {
        [newStr replaceCharactersInRange:subStr4 withString:replace];
        subStr4 =[newStr rangeOfString:@"</P> <P>"];
    }
    
    return newStr;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"------111111:%f",_cellHeight);
    return _cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

-(void)pushSearchDetailsViewControllerWithID:(NSString *)idNumber
{
    CommonSearchDetailsViewController *searchDetailsView =[[CommonSearchDetailsViewController alloc]init];
    searchDetailsView.ID = idNumber;
    [self.navigationController pushViewController:searchDetailsView animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CommonDetailsContentList *list = _detailsModel.contentlist[indexPath.section];
    [_cell.delegate pushSearchDetailsViewControllerWithID:list.ID];
    NSLog(@"%@",list.ID);
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
