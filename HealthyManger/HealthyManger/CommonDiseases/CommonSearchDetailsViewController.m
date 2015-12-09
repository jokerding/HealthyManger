//
//  CommonSearchDetailsViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommonSearchDetailsViewController.h"


#import "AFNetworking.h"
#import "MJExtension.h"

#import "commonSearchDetailsModel.h"

#import "SearchDetailsTableViewCell.h"
#import "SearchDetailsTableHeaderView.h"

@interface CommonSearchDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)commonSearchDetailsModel *model;

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong)SearchDetailsTableViewCell *cell;

@property (nonatomic,copy)NSString *HTMLstr;

@property (nonatomic,strong)NSMutableDictionary *headerViewDic;


@end

@implementation CommonSearchDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self createTableView];
    
    [self getHttpData];
    
}

-(void)getHttpData
{
    _headerViewDic =[NSMutableDictionary dictionary];

    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:API_URL_COMMON_DISEASES_MX,_ID,self.currentDate];
    self.httpUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"%@",operation.responseString);
        _model =[[commonSearchDetailsModel alloc]mj_setKeyValues:operation.responseString];
        //NSLog(@"%@",_model.tagList);
        
        [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}


-(void)createTableView
{
    _table =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.bounces = NO;
    _table.showsVerticalScrollIndicator = NO;
    _table.rowHeight = UITableViewAutomaticDimension;

    UINib *nib =[UINib nibWithNibName:@"SearchDetailsTableViewCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"SearchDetailsTableViewCell"];
    
    [self.view addSubview:_table];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _model.tagList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    commonSearchDetailsTagList *list = _model.tagList[section];
    
    if (list.isOpenGroup)
    {
        ///NSLog(@"打开");
        return 1;
    }
    else
    {
        //NSLog(@"关闭");
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:@"SearchDetailsTableViewCell"];
    if (!_cell)
    {
        _cell =[[SearchDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchDetailsTableViewCell"];
    }
    commonSearchDetailsTagList *list = _model.tagList[indexPath.section];
    
    _cell.content.scrollView.bounces = NO;

    _HTMLstr = list.content;
    
    [_cell.content loadHTMLString:_HTMLstr baseURL:nil];
    
    list.cellHeight = _cell.content.scrollView.contentSize.height;
    
   // NSLog(@"%f",list.cellHeight);
    
    return  _cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    commonSearchDetailsTagList *list = _model.tagList[indexPath.section];
    
    NSLog(@"%f",list.cellHeight);
    return  list.cellHeight;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //[headerView configUIWithModel:_model.tagList[section]];
    
    SearchDetailsTableHeaderView *headerView = [_headerViewDic objectForKey:@(section)];
    if (!headerView)
    {
        headerView =[[SearchDetailsTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,40.0)];
        headerView.model = _model.tagList[section];
        headerView.openGroup = ^{
           
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        };
        [_headerViewDic setObject: headerView forKey:@(section)];
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
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
