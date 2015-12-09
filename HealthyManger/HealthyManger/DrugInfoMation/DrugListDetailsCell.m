//
//  DrugListDetailsCell.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugListDetailsCell.h"
#import "UIImageView+AFNetworking.h"
@implementation DrugListDetailsCell

- (void)awakeFromNib {
    // Initialization code
    
//    _drugPrice.layer.borderColor = [UIColor whiteColor].CGColor;
//    _drugPrice.layer.borderWidth = 1.0;
//    _drugPrice.layer.cornerRadius = 10.0;
//    _drugPrice.layer.masksToBounds = YES;
    
}

-(void)setModel:(DrugListDetailsModel *)model
{
    if (_model != model)
    {
        _model = model;
        _drugName.text = model.name;
        _drugTag.text = model.tag;
        _drugType.text = model.type;
        _drugDes.text = model.Description;
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",model.img]];
        _drugPrice.text = [NSString stringWithFormat:@"￥:%@",model.price];
        [_drugImg setImageWithURL:url];
        
        _cellHeight = _drugDes.frame.origin.y + _drugDes.frame.size.height + 10.0;
        NSLog(@"%f",_cellHeight);

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
