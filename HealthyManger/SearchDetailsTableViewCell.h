//
//  SearchDetailsTableViewCell.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonSearchDetailsModel.h"
@interface SearchDetailsTableViewCell : UITableViewCell

@property (nonatomic,weak)IBOutlet UIWebView *content;

@property (nonatomic,strong)commonSearchDetailsTagList *listModel;

@end
