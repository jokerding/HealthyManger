//
//  CommonSubTableView.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonSubTableView : UIView
@property (nonatomic,assign)CGFloat rowHeight;
@property (nonatomic,assign)NSInteger sectionsCount;
-(void)createTableViewWithArray:(NSArray *)subList andTitle:(NSString *)subListTitle;
@end
