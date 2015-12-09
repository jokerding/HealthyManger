//
//  porvinceCellView.h
//  HealthyManger
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface porvinceCellView : UIView
-(void)createTableViewWithArray:(NSMutableArray *)array;
@property (nonatomic,copy)void(^slectPorvice)(NSString *porviceName,NSNumber *ID);
@end
