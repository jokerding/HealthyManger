//
//  subCollctionView.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  subCollctionViewDelegate <NSObject>

-(void)pushDetailsViewWithSubId:(NSString *)subId andTypeId:(NSString *)typeId;

@end

@interface subCollctionView : UIView

-(void)createCollectionWithArray:(NSArray *)array andSubTitle:(NSString *)subTitle andTypeId:(NSString *)typeId;

@property (nonatomic,assign)id<subCollctionViewDelegate>deletage;
@end
