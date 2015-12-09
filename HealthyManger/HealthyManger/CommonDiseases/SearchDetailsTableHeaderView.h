//
//  SearchDetailsTableHeaderView.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonSearchDetailsModel.h"

@interface SearchDetailsTableHeaderView : UIView
@property (nonatomic,strong)commonSearchDetailsTagList *model;

@property (nonatomic,copy)void(^openGroup)();
// 此方法不用
-(void)configUIWithModel:(commonSearchDetailsTagList *)list;

@end
