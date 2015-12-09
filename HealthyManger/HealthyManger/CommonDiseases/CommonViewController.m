//
//  CommonViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define MAIN_SCREEN_SIZE [UIScreen mainScreen].bounds.size

#import "CommonViewController.h"
#import "CommonDetailsViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"

#import "CommonModel.h"


#import "CommonSubTableView.h"
#import "CollectionViewCell.h"
#import "subCollctionView.h"



@interface CommonViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,subCollctionViewDelegate>


@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong)CommonModel *commonModel;


@property (nonatomic,assign)CGFloat rowHeight;

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UICollectionView *Colloction;

@property (nonatomic,assign)NSTimer *timer;

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
 
  
    [self getNetdata];
    
    [self configUIForCollectionView];
      //[self configUI];
    
    [self confgiNaviUI];
    
 
}

-(void)confgiNaviUI
{
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0,30,30);
    [backBtn setImage:[UIImage imageNamed:@"icon_sleep"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backHomePage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.title = @"常见疾病科目类别";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}




-(void)backHomePage
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)pushDetailsViewWithSubId:(NSString *)subId andTypeId:(NSString *)typeId
{
    NSLog(@"测试推送");
    
    CommonDetailsViewController *detailsView = [[CommonDetailsViewController alloc]init];
    detailsView.subTypeID = subId;
    detailsView.typeId = typeId;
    
    [self.navigationController pushViewController:detailsView animated:YES];
}
-(void)getNetdata
{
    NSString *url = [NSString stringWithFormat:API_URL_COMMON_DISEASES_KM,self.currentDate];
    self.httpUrl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         //NSLog(@"%@",operation.responseString);
        _commonModel = [[CommonModel alloc]mj_setKeyValues:operation.responseString];
       // NSLog(@"%@",_commonModel.list);
        
        //[_table reloadData];
        [_Colloction reloadData];
       
        [self createScrollView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}



#pragma mark -- collectionView
-(void)configUIForCollectionView
{
    
    
    CGSize size = SCRREN_MAIN_SIZE;
    CGFloat distance = 10.0;
    CGFloat width = (size.width - 3.0*distance)/2.0;
    CGFloat height = 40;
    
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    _Colloction =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    _Colloction.delegate = self;
    _Colloction.dataSource = self;
    _Colloction.backgroundColor =[UIColor whiteColor];
    
    UINib *nib =[UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [_Colloction registerNib:nib forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    [self.view addSubview:_Colloction];
    
    
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _commonModel.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"CollectionViewCell"forIndexPath:indexPath];
    CommonListModel *model = _commonModel.list[indexPath.row];
    cell.typeNameLab.text = model.typeName;
    
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    subCollctionView *subCollection = [[subCollctionView alloc]initWithFrame:CGRectMake(0,_scrollView.frame.size.height *indexPath.row, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    [_scrollView addSubview:subCollection];
    subCollection.deletage = self;
    
    CommonListModel *model = _commonModel.list[indexPath.row];
    
    [subCollection createCollectionWithArray:model.subList andSubTitle:model.typeName andTypeId:model.typeId];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width,_scrollView.frame.size.height*(indexPath.row +1));

    _scrollView.contentOffset = CGPointMake(0,_scrollView.bounds.size.height*indexPath.row);
}

-(void)createScrollView
{
    CGFloat ponint_y = (44.0+(_commonModel.list.count/2.0+1.0)*40.0);
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, ponint_y, SCRREN_MAIN_SIZE.width, SCRREN_MAIN_SIZE.height - ponint_y)];
    //_scrollView.backgroundColor = [UIColor colorWithRed:1.000 green:0.946 blue:0.743 alpha:0.500];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
}













#pragma mark -- tableView
-(void)configUI
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.table =[[UITableView alloc]initWithFrame:CGRectMake(0,20,size.width/2.0,size.height ) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table .dataSource = self;
    self.table.bounces = NO;
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.showsVerticalScrollIndicator = NO;
    
    //[self.table registerClass:[CommonCell class] forCellReuseIdentifier:@"CommonCell"];
    
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(size.width/2.0, 20.0, size.width, size.height)];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    //_scrollView.backgroundColor =[UIColor redColor];
    
    
    [self.view addSubview:self.table];
    [self.view addSubview:_scrollView];

}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    //NSLog(@"%ld",_commonModel.list.count);
    return _commonModel.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"CommonCell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    CommonListModel *model = _commonModel.list[indexPath.row];
    cell.textLabel.text = model.typeName;
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.imageView.image =[UIImage imageNamed:@"icon_plan_detail"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:0.435 green:0.788 blue:1.000 alpha:0.630];
    //NSLog(@"%@",model.typeName);
    return  cell;
}
  
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _rowHeight = (([UIScreen mainScreen].bounds.size.height-20.0)/ _commonModel.list.count);
    return (([UIScreen mainScreen].bounds.size.height-20.0)/ _commonModel.list.count);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonSubTableView *subTable = [[CommonSubTableView alloc]initWithFrame:CGRectMake(0,MAIN_SCREEN_SIZE.height*indexPath.row,_scrollView.bounds.size.width,_scrollView.bounds.size.height)];
    CommonListModel *model = _commonModel.list[indexPath.row];
    subTable.rowHeight = _rowHeight;
    subTable.sectionsCount = _commonModel.list.count;
    [subTable createTableViewWithArray:model.subList andTitle:model.typeName];
   

    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width,_scrollView.frame.size.height);
    
    _scrollView.contentOffset = CGPointMake(0, _scrollView.bounds.size.height * indexPath.row);
    [_scrollView addSubview:subTable];
    
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
