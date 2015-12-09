//
//  BaseViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"

#import "CommonModel.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.082 green:0.545 blue:0.349 alpha:1.000];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCurrentDate];
//    [self getNetdata];

    
}


-(void)loadCurrentDate
{
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    _currentDate = [formatter stringFromDate:date];
    //NSLog(@"%@",_currentDate);
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
