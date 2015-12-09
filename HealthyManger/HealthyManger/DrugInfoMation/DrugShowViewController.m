//
//  DrugShowViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugShowViewController.h"


#import "AFNetworking.h"
#import "MJExtension.h"

#import "DrugShowModel.h"

@interface DrugShowViewController ()
@property (nonatomic,strong)DrugShowModel *showModel;
@property (nonatomic,strong)UIWebView *showWeb;
@end

@implementation DrugShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor redColor];
    [self getHttpData];
    [self creteWebView];
    
}


-(void)getHttpData
{
    NSString *url =[NSString stringWithFormat:TGAPI_DRUG_SHOW,_ID];
    self.httpUrl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manger =[AFHTTPRequestOperationManager manager];
    manger.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manger.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    [manger GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",operation.responseString);
        
        _showModel = [[DrugShowModel alloc]mj_setKeyValues:operation.responseString];
        NSLog(@"%@",_showModel.message);
        [_showWeb loadHTMLString:_showModel.message baseURL:nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void)creteWebView
{
    _showWeb =[[UIWebView alloc]initWithFrame:self.view.frame];
    _showWeb.scrollView.bounces = NO;
   
  
    [self.view addSubview:_showWeb];
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
