//
//  DrugSubClassViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugSubClassViewController.h"
#import "DrugListViewController.h"

#import "DrugClassModel.h"

#import "AFNetworking.h"
#import "MJExtension.h"

@interface DrugSubClassViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong)NSMutableArray *modelArray;

@end

@implementation DrugSubClassViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    _modelArray =[NSMutableArray array];
    
    [self getHttpData];
    [self createTable];
}



-(void)getHttpData
{
    NSString *url =[NSString stringWithFormat:TGAPI_DRUG_CLASS,_ID];
    self.httpUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _modelArray = [DrugClassModel mj_objectArrayWithKeyValuesArray:operation.responseString];
         [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void)createTable
{
    _table =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_table];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"subClass数据模型数量:%ld",_modelArray.count);
    return _modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenfi = @"drugList";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:idenfi];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idenfi];
    }
    
    DrugClassModel *model = _modelArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.Description;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DrugListViewController *drugListView =[[DrugListViewController alloc]init];
    DrugClassModel *model = _modelArray[indexPath.row];
    drugListView.ID = model.ID;
    
    drugListView.navigationItem.title = @"药品列表";
   
    
    [self.navigationController pushViewController:drugListView animated:YES];
    
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
