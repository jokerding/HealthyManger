//
//  ADLBView.h
//  day-15-02-广告轮播方法封装
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADLBView : UIView
// 提供接口
@property (nonatomic,assign)UIEdgeInsets boardWidth;
// 提供边栏的尺寸属性
@property (nonatomic,strong)UIColor *boardColer;
// 提供边栏的颜色

#pragma mark -- 广告轮播(页数及删除)
-(instancetype)initWithFrame:(CGRect)frame WhitIamges:(NSArray *)images WithCallBack:(void(^)(NSInteger chooseIndex))callBack;
// 提供初始化的方法接口

#pragma mark -- 广告轮轮(小圆点)
-(instancetype)initWithFrame:(CGRect)frame WhitIamges:(NSArray *)images WithPageControllCallBack:(void (^)(NSInteger chooseIndex))callBack;
@end
