//
//  ComonDetailsTableViewCell.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ComonDetailsTableViewCell.h"

@implementation ComonDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setList:(CommonDetailsContentList *)list
{
    if (_list != list)
    {
        _list = list;
        
        _idNumberLab.text = list.ID;
        _nameLab.text = list.name;
       
        _summaryLab.font =[UIFont systemFontOfSize:15.0];

         UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.borderWidth = 2.0;
        view.layer.borderColor =[UIColor colorWithRed:0.000 green:0.546 blue:0.000 alpha:1.000].CGColor;
        view.layer.cornerRadius = 5.0;
        view.layer.masksToBounds = YES;
    
        self.backgroundView = view;
    }
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
