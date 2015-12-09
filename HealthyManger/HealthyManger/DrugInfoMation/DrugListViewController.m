//
//  DrugListViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugListViewController.h"
#import "DrugListModel.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "DrugListDetailsCell.h"

@interface DrugListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)DrugListModel *listModel;

@property (nonatomic,strong)NSMutableArray *listModelArray;

@end

@implementation DrugListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    _listModelArray =[NSMutableArray array];
    _page = 1;
    
    [self getHttpData];
    [self createTable];
}



-(void)getHttpData
{
    NSString *url =[NSString stringWithFormat:TGAPI_DRUG_LIST,_ID,_page];
    self.httpUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSLog(@"-----%@",self.httpUrl);
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSLog(@"%@",operation.responseString);
 
        _listModel = [[DrugListModel alloc]mj_setKeyValues:operation.responseString];
        
        [_listModelArray addObjectsFromArray:_listModel.tngou];
        NSLog(@"%ld",_listModelArray.count);
        [_table reloadData];
        [_table.header endRefreshing];
        [_table.footer endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [_table.header endRefreshing];
        [_table.footer endRefreshing];
    }];
}



-(void)createTable
{
    _table =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    UINib *nib =[UINib nibWithNibName:@"DrugListDetailsCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"DrugListDetailsCell"];
    
    __block id weakSefl = self;
    _table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_listModelArray removeAllObjects];
        _page = 1;
        [weakSefl getHttpData];
    }];
    _table.footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSefl getHttpData];
    }];
    
    [self.view addSubview:_table];
    [_table.header beginRefreshing];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%ld",_listModel.tngou.count);
    return _listModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DrugListDetailsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DrugListDetailsCell"];
    if (!cell)
    {
        cell =[[DrugListDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DrugListDetailsCell"];
    }
    if (_listModelArray.count)
    {
        cell.model = _listModelArray[indexPath.row];
    }
    _height = cell.cellHeight;
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _height;
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
