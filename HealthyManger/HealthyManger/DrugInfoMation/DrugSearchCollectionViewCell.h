//
//  DrugSearchCollectionViewCell.h
//  HealthyManger
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugSearchModel.h"

@interface DrugSearchCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)DrugSearchListModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *drugImage;
@property (weak, nonatomic) IBOutlet UILabel *drugName;
@property (weak, nonatomic) IBOutlet UILabel *drugPrice;

@end
