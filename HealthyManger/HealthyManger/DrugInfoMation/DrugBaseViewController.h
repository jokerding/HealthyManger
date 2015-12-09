//
//  DrugBaseViewController.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkingBaseViewController.h"
@interface DrugBaseViewController :NetworkingBaseViewController

@property (nonatomic,copy)NSString *currentDate;
@property (nonatomic,copy)NSString *httpUrl;
-(void)loadCurrentDate;

@end
