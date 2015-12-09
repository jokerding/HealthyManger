//
//  DruginfoViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DruginfoViewController.h"

@interface DruginfoViewController ()

@end

@implementation DruginfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initTabbarItems];
    //[self configNaviUI];
}

-(void)initTabbarItems
{
    NSArray *titleArray = @[@"药品大全",@"药品搜索",@"药品扫描",@"药企大全"];
    int i = 0;
    for (UINavigationController *navi in self.viewControllers)
    {
        UIViewController *vc = navi.viewControllers.firstObject;
        
        
        UIImage *itemImage =[UIImage imageNamed:[NSString stringWithFormat:@"tab%d_1",i+1]];
        UIImage *selectedImage =[UIImage imageNamed:[NSString stringWithFormat:@"tab%d_2",i+1]];
        
        itemImage =[itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       
        
        vc.tabBarItem =[[UITabBarItem alloc]initWithTitle:titleArray[i] image:itemImage selectedImage:selectedImage];
        i++;
    }

}


-(void)configNaviUI
{
    NSLog(@"测试....");
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0,30,30);
    [backBtn setImage:[UIImage imageNamed:@"icon_sleep"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backHomePage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}

-(void)backHomePage
{
    [self.navigationController popViewControllerAnimated:YES];
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
