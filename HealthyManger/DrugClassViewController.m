//
//  DrugClassViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugClassViewController.h"
#import "DrugSearchViewController.h"
#import "DrugSubClassViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"

#import "DrugClassModel.h"

@interface DrugClassViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong)DrugClassModel *model;

@property (nonatomic,strong)NSMutableArray *modelArray;

@property (nonatomic,copy)NSNumber *ID;

@end

@implementation DrugClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor redColor];
    _modelArray =[NSMutableArray array];
    
    _ID = 0;
    
    [self getHttpData];
    
    [self createTableView];
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
        //NSLog(@"%@",_modelArray);
        
  
        [_table reloadData];
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void)createTableView
{
    _table =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    
    
    [self.view addSubview:_table];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIden];
    }
    DrugClassModel *model = _modelArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.Description;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DrugSubClassViewController *subClassView = [[DrugSubClassViewController alloc]init];
    DrugClassModel *model = _modelArray[indexPath.row];
    subClassView.navigationItem.title = model.title;
    subClassView.ID= model.ID;
    [self.navigationController pushViewController:subClassView animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
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
