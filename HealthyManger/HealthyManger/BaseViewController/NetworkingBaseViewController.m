//
//  NetworkingBaseViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NetworkingBaseViewController.h"
#import "AFNetworking.h"


@interface NetworkingBaseViewController ()

@end

@implementation NetworkingBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -- 创建网络监控
-(void)networkStateMonitoringManager
{
    // 创建网络监听对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 开启监听
    [manager startMonitoring];
    
    // 检测网络状态
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                [self showMessageWithText:@"没有网络,请检查你的手机是否打开峰窝移动!"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self showMessageWithText:@"你正在使用3G/4G上网!"];
                break;
                
            default:
                break;
        }
    }];
    
}
#pragma mark -- 根据网络状态进行提示
-(void)showMessageWithText:(NSString *)message
{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
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
