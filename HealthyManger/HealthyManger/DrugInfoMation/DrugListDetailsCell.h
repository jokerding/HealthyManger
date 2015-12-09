//
//  DrugListDetailsCell.h
//  HealthyManger
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DrugListModel.h"

@interface DrugListDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *drugImg;
@property (weak, nonatomic) IBOutlet UILabel *drugName;
@property (weak, nonatomic) IBOutlet UILabel *drugTag;
@property (weak, nonatomic) IBOutlet UILabel *drugType;
@property (weak, nonatomic) IBOutlet UILabel *drugDes;
@property (weak, nonatomic) IBOutlet UILabel *drugPrice;

@property (strong,nonatomic)DrugListDetailsModel *model;

@property (assign,nonatomic)CGFloat cellHeight;
@end
