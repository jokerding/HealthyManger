//
//  DrugDetailsCell.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugSearchModel.h"
@interface DrugDetailsCell : UITableViewCell
@property (nonatomic,strong)DrugSearchListModel *model;

@property (nonatomic,assign)CGFloat cellHeight;


@end
