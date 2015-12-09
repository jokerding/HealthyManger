//
//  ComonDetailsTableViewCell.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDetailsModel.h"

@protocol ComonDetailsTableViewCellDelegate <NSObject>

-(void)pushSearchDetailsViewControllerWithID:(NSString *)idNumber;

@end

@interface ComonDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *idNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *summaryLab;
@property (nonatomic,assign)id<ComonDetailsTableViewCellDelegate>delegate;
@property (nonatomic,strong)CommonDetailsContentList *list;
@end
