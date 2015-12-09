//
//  DrugSearchCollectionViewCell.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugSearchCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation DrugSearchCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.borderColor =[UIColor colorWithRed:0.056 green:0.500 blue:0.469 alpha:1.000].CGColor;
    self.layer.borderWidth = 2.0;
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;

}

-(void)setModel:(DrugSearchListModel *)model
{
    if (_model != model)
    {
        _model = model;
        _drugName.text = model.name;
        _drugPrice.text = [NSString stringWithFormat:@"￥:%@",model.price];
        [_drugImage setImageWithURL:[NSURL URLWithString:model.img]];
    }
}

@end
