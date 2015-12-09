//
//  BaseViewController.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NetworkingBaseViewController.h"

@interface BaseViewController : NetworkingBaseViewController
@property (nonatomic,copy)NSString *currentDate;
@property (nonatomic,copy)NSString *httpUrl;
-(void)loadCurrentDate;

@end
