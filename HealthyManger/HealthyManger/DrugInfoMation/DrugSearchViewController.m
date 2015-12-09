//
//  DrugSearchViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugSearchViewController.h"
#import "DrugShowViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"

#import "DrugSearchModel.h"

#import "MJRefresh.h"

#import "DrugSearchCollectionViewCell.h"

@interface DrugSearchViewController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)DrugSearchModel *model;

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,assign)NSInteger row;

@property (nonatomic,assign)CGFloat height;

@property (nonatomic,strong)NSMutableArray *modelListArray;

@property (nonatomic,strong)UITextField *searchTextField;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,copy)NSString *keyword;
@end

@implementation DrugSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self configUI];
    
    [self createCollectionView];
   
    _modelListArray = [NSMutableArray array];
    _row = 20;
}

-(void)configUI
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 20.0);
    UIView *searchView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 44.0)];
    searchView.center = self.view.center;
    searchView.layer.borderColor =[UIColor colorWithRed:0.137 green:0.545 blue:0.369 alpha:1.000].CGColor;
    searchView.layer.borderWidth = 2.0;
    searchView.layer.cornerRadius = 5.0;
    searchView.tag = 1000;
    searchView.layer.masksToBounds = YES;
    
    
    UIImageView *searchImg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,35.0,28.0)];
     searchImg.image =[UIImage imageNamed:@"tab2_2"];
    searchImg.center = CGPointMake(15.0,22.0);
    
    _searchTextField =[[UITextField alloc]initWithFrame:CGRectMake(0, 0, width, 44)];
    
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextField.placeholder = @"输入关键字进行搜索,例:感冒";
    _searchTextField.font =[UIFont systemFontOfSize:14.0];
    _searchTextField.textAlignment = NSTextAlignmentCenter;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.delegate = self;
    [searchView addSubview:_searchTextField];
    [searchView addSubview:searchImg];

    
    [self.view addSubview:searchView];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIView *view = (id)[self.view viewWithTag:1000];
    [textField resignFirstResponder];
    //NSLog(@"搜索中.....");
    
    CGRect frame = view.frame;
     frame = CGRectMake(frame.origin.x, 70.0, frame.size.width, frame.size.height);
    
    CGRect frame2 = _collectionView.frame;
    frame2 = CGRectMake(frame2.origin.x,CGRectGetMaxY(frame)+10.0 , frame2.size.width, frame2.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame= frame;
        _collectionView.frame = frame2;
    }];
    
    [self getHttpData];
    _keyword = textField.text;
    textField.text = nil;
    
    
    
    return YES;
}

-(void)getHttpData
{
    NSString *url = [NSString stringWithFormat:TGAPI_DRUG_SEARCH,_keyword,_row];
    
    self.httpUrl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"---%@",self.httpUrl);
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",operation.responseString);
        _model = [[DrugSearchModel alloc]mj_setKeyValues:operation.responseString];
        [_modelListArray addObjectsFromArray:_model.tngou];
        [_collectionView reloadData];
       
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        
         NSLog(@"停止刷新");
         NSLog(@"数据模型数量%ld",_modelListArray.count);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
    }];
}

-(void)createCollectionView
{
    //CGFloat edig_distance = 30.0;
    CGFloat width = (SCRREN_MAIN_SIZE.width -30.0)/2.0;
    CGFloat height = width * 0.75;
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
   
    flowLayout.minimumInteritemSpacing = 5.0;
    flowLayout.minimumLineSpacing = 10.0;
    
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(5.0,self.view.frame.size.height, self.view.frame.size.width-10.0, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor =[UIColor whiteColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    UINib *nib =[UINib nibWithNibName:@"DrugSearchCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"DrugSearchCollectionViewCell"];
    
    
    __block id weakSelf = self;
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_modelListArray removeAllObjects];
        _row = 20;
        [weakSelf getHttpData];
        
    }];
    
    _collectionView.footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _row += 20;
        [weakSelf getHttpData];
        NSLog(@"%ld",_row);
    }];
    [self.view addSubview:_collectionView];
    [_collectionView.header beginRefreshing];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelListArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrugSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DrugSearchCollectionViewCell" forIndexPath:indexPath];
    if (_modelListArray.count)
    {
        cell.model = _modelListArray[indexPath.row];
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrugSearchListModel *model = _modelListArray[indexPath.row];
    DrugShowViewController *showView =[[DrugShowViewController alloc]init];
    showView.navigationItem.title = @"药品详情";
    showView.ID = model.ID;
    [self.navigationController pushViewController:showView animated:YES];
    
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
