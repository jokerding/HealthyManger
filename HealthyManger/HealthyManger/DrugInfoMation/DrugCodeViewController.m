//
//  DrugCodeViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugCodeViewController.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MJExtension.h"
#import "ARZBarController.h"

#import "DrugCodeModel.h"

@interface DrugCodeViewController ()<UITextFieldDelegate,UIAlertViewDelegate,ARZBarControllerDelegate>
@property (nonatomic,strong)UITextField *searchTextField;
@property (nonatomic,copy)NSString *code;
@property (nonatomic,strong)DrugCodeModel *codeModel;
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation DrugCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self createUI];
    //[self getHttpData];
    [self createShowInfo];
}

-(void)createUI
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
    
    _searchTextField =[[UITextField alloc]initWithFrame:CGRectMake(0, 0,width-40.0, 44)];
    
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextField.placeholder = @"请输入13位条形码数字";
    _searchTextField.font =[UIFont systemFontOfSize:14.0];
    _searchTextField.textAlignment = NSTextAlignmentCenter;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.delegate = self;
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMaxX(_searchTextField.frame),2.0,40.0,40.0);
    [btn setBackgroundImage:[UIImage imageNamed:@"tab3_2"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushZBar:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [searchView addSubview:_searchTextField];
    [searchView addSubview:searchImg];
    [searchView addSubview:btn];
    
    
    [self.view addSubview:searchView];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    UIView *view1 = (id)[self.view viewWithTag:1000];
    
    UIView *view2 = (id)[self.view viewWithTag:2000];
    
    CGRect frame1 = view1.frame;
    frame1 = CGRectMake(frame1.origin.x, 70.0, frame1.size.width, frame1.size.height);
    
    CGRect frame2 = view2.frame;
    frame2 = CGRectMake(0, CGRectGetMaxY(frame1)+ 5.0, frame2.size.width, frame2.size.height);
    
    
    [UIView animateWithDuration:0.5 animations:^{
        view1.frame = frame1;
        view2.frame = frame2;
    }];
    
    
    _code = textField.text;
    [textField resignFirstResponder];
    textField.text = nil;
    [self getHttpData];
    
    return YES;
}

-(void)createShowInfo
{
    CGFloat width = SCRREN_MAIN_SIZE.width - 30.0;
    CGFloat height = width * 0.75;
    
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    backView.tag = 2000;
    
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(15.0,5.0, width, height)];
    
    
    
    imgView.tag = 3000;
    
    
    [backView addSubview:imgView];
    
    _webView =[[UIWebView alloc]initWithFrame:CGRectMake(15.0, CGRectGetMaxY(imgView.frame)+ 5.0, width,backView.bounds.size.height - imgView.bounds.size.height-164.0)];
   
    _webView.scrollView.bounces = NO;
    
    [backView addSubview:_webView];
    
    [self.view addSubview:backView];
    
}

-(void)getHttpData
{
    NSString *str = [NSString stringWithFormat:TGAPI_DRUG_CODE,_code];
    self.httpUrl = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    
    __block id weakSelf = self;
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",operation.responseString);
        _codeModel = [[DrugCodeModel alloc]mj_setKeyValues:operation.responseString];
        NSLog(@"%@",_codeModel.Description);
        
        
        if (_codeModel.message == nil)
        {
            [weakSelf createAlertView];
        }
        else
        {
            
            NSString *imgUrl = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_codeModel.img];
            NSLog(@"%@",imgUrl);
            UIImageView *imgView = (UIImageView *)[self.view viewWithTag:3000];
            imgView.layer.borderColor =[UIColor colorWithRed:0.184 green:0.545 blue:0.388 alpha:1.000].CGColor;
            imgView.layer.borderWidth = 1.5;
            imgView.layer.cornerRadius = 5.0;
            imgView.layer.masksToBounds = YES;
            
            [imgView setImageWithURL:[NSURL URLWithString:imgUrl]];
            
            [_webView loadHTMLString:_codeModel.message baseURL:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void)createAlertView

{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"非常抱歉,无此药品数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    
}


-(void)pushZBar:(UIButton *)sender
{
    ARZBarController *arzBar =[[ARZBarController alloc]init];
    arzBar.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:arzBar animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


-(void)reciveData:(NSString *)data isSuccess:(BOOL)isSuccess
{
    _code = data;
    
    self.navigationController.navigationBarHidden = NO;
    
    
    UIView *view1 = (id)[self.view viewWithTag:1000];
    
    UIView *view2 = (id)[self.view viewWithTag:2000];
    
    CGRect frame1 = view1.frame;
    frame1 = CGRectMake(frame1.origin.x, 70.0, frame1.size.width, frame1.size.height);
    
    CGRect frame2 = view2.frame;
    frame2 = CGRectMake(0, CGRectGetMaxY(frame1)+ 5.0, frame2.size.width, frame2.size.height);
    
    
    [UIView animateWithDuration:0.5 animations:^{
        view1.frame = frame1;
        view2.frame = frame2;
    }];

    [self getHttpData];
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
