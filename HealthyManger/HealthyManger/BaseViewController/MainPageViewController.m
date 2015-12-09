//
//  MainPageViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainPageViewController.h"

#import "BaseViewController.h"

#import "CommonViewController.h"
#import "DruginfoViewController.h"

@interface MainPageViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *commonDiseases;
@property (weak, nonatomic) IBOutlet UIButton *hospital;
@property (weak, nonatomic) IBOutlet UIButton *drugInfoMation;
@property (weak, nonatomic) IBOutlet UIButton *HealthKonwledge;
@property (weak, nonatomic) IBOutlet UIButton *more;

@property (nonatomic,strong)UITextField *searTextField;



@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:0.137 green:0.545 blue:0.369 alpha:1.000];
    
    [self configNave];
}

-(void)configNave
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 100.0);
    
    UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, width,44.0)];
   // titleView.backgroundColor =[UIColor redColor];
    CGFloat Y = titleView.center.y;

    
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0,0,20.0,15.0)];
    img.center = CGPointMake(15.0, Y);
    img.image =[UIImage imageNamed:@"tab2_2"];
    
    
    
    _searTextField = [[UITextField alloc]initWithFrame:CGRectMake(0,0,width,30)];
    _searTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searTextField.placeholder = @"疾病名称/医院名称/药品名称";
    _searTextField.font = [UIFont systemFontOfSize:12];
    _searTextField.textAlignment = NSTextAlignmentCenter;
    _searTextField.returnKeyType = UIReturnKeySearch;
    _searTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _searTextField.center = titleView.center;
    _searTextField.delegate = self;
    
    
    [titleView addSubview:_searTextField];
    [titleView addSubview:img];
    
    UIButton *leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0,15.0,30.0);
    [leftBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 5;
    
    
    self.navigationItem.titleView = titleView;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
}

- (IBAction)btnClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            //NSLog(@"常见疾病");
            CommonViewController *vc =[[CommonViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case 1:
            NSLog(@"医院大全");
            break;
        case 2:
        {
            NSLog(@"药品药企");
            break;
        }
          
        case 3:
            NSLog(@"健康知识");
            break;
        case 4:
            NSLog(@"更多");
            break;
        case 5:
            NSLog(@"用户信息");
            break;

        default:
            break;
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"搜索中.....");
    [textField resignFirstResponder];
    return YES;
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
