//
//  FactoryListInfoCell.h
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactoryListModel.h"
@interface FactoryListInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *FactoryLogo;
@property (weak, nonatomic) IBOutlet UILabel *FactoryName;
@property (weak, nonatomic) IBOutlet UILabel *FactoryTel;
@property (weak, nonatomic) IBOutlet UILabel *FactoryHttp;
@property (weak, nonatomic) IBOutlet UILabel *FactoryAdds;

//@property (nonatomic,strong) UILabel *FactoryAdds;

@property (nonatomic,strong)FactoryListInfoModel *model;

@property (nonatomic,assign)CGFloat cellHeight;
@end
