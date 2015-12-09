//
//  FactoryShowViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FactoryShowViewController.h"
#import "UIView+ProgressView.h"

@interface FactoryShowViewController ()<UIWebViewDelegate,UIAlertViewDelegate>

@end

@implementation FactoryShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.title = @"药企详情";
    [self createWebView];
    [self createGCD];
}

-(void)createGCD
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(queue, ^{
       
      
    });

    dispatch_async(global, ^{
        
        UIWebView *web = (UIWebView *)[self.view viewWithTag:1000];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
        NSLog(@"web加载数据");
    });
    
    
}

-(void)createWebView
{
    NSLog(@"创建web");
    
    UIWebView *webView =[[UIWebView alloc]initWithFrame:self.view.frame];
    
    webView.delegate = self;
    
    webView.tag = 1000;
    
    webView.scalesPageToFit = YES;
    
    webView.scrollView.bounces = NO;

    [self.view addSubview:webView];
}
   

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
    [self.view showJUHUAWithBool:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
    [self.view showJUHUAWithBool:NO];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载错误");
    
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"网站无法加载" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    
   
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
