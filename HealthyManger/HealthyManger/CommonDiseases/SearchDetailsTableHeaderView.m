//
//  SearchDetailsTableHeaderView.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchDetailsTableHeaderView.h"

@interface SearchDetailsTableHeaderView()
@property (nonatomic,strong)UIImageView *img;

@end

@implementation SearchDetailsTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        //self.backgroundColor = [UIColor colorWithRed:1.000 green:0.063 blue:0.092 alpha:1.000];
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    UILabel *nameLab =[[UILabel alloc]initWithFrame:CGRectMake(10.0,10.0,SCRREN_MAIN_SIZE.width - 20.0,20.0)];
    
    nameLab.textColor =[UIColor colorWithRed:0.137 green:0.541 blue:0.365 alpha:1.000];
    //nameLab.text = list.name;
    nameLab.tag = 1000;
    _img =[[UIImageView alloc]initWithFrame:CGRectMake(nameLab.frame.size.width-10.0,10.0,20.0,20.0)];
    _img.image =[UIImage imageNamed:@"icon_arrow_test_next"];
    
    [self addSubview:nameLab];
    [self addSubview:_img];
}


-(void)configUIWithModel:(commonSearchDetailsTagList *)list
{
    UILabel *nameLab =[[UILabel alloc]initWithFrame:CGRectMake(10.0,10.0,SCRREN_MAIN_SIZE.width - 20.0, 20.0)];

    nameLab.textColor =[UIColor colorWithRed:0.137 green:0.541 blue:0.365 alpha:1.000];
    nameLab.text = list.name;
    _img =[[UIImageView alloc]initWithFrame:CGRectMake(nameLab.frame.size.width-10.0,10.0,20.0,20.0)];
    _img.image =[UIImage imageNamed:@"icon_arrow_test_next"];
    
    [self addSubview:nameLab];
    [self addSubview:_img];
}

-(void)setModel:(commonSearchDetailsTagList *)model
{
    if (_model != model)
    {
        _model = model;
        UILabel *lab = (UILabel *)[self viewWithTag:1000];
        lab.text = model.name;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _model.isOpenGroup = !_model.isOpenGroup;
    _openGroup();
    if (_model.isOpenGroup)
    {
        //NSLog(@"打开");
        [UIView animateWithDuration:0.1 animations:^{
            _img.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
      }
    else
    {
        //NSLog(@"关闭");
        [UIView animateWithDuration:0.1 animations:^{
            _img.transform = CGAffineTransformMakeRotation(0);
        }];
    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
