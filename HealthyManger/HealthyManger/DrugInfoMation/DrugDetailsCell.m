//
//  DrugDetailsCell.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugDetailsCell.h"
#import "UIImageView+AFNetworking.h"

@implementation DrugDetailsCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    CGFloat  edge_distance = 10.0;
    CGFloat h_distance = 5.0;
    
    CGFloat img_width = SCRREN_MAIN_SIZE.width - 100.0;
    CGFloat img_height = img_width * 0.8;
    
    CGFloat lab_width = 60.0;
    CGFloat lab_height = 20.0;
    
    CGFloat desLab_width= SCRREN_MAIN_SIZE.width - 85.0;
    
    
    NSArray *labName =@[@"品名:",@"禁忌:",@"生产企业:",@"批准文号:",@"适应症:",@"用法用量:",@"有效期:",@"储藏方法:",@"主要成份:"];
    
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(50.0, edge_distance, img_width, img_height)];
    imgView.tag = 1000;
    
    UILabel *price =[[UILabel alloc]initWithFrame:CGRectMake(0,0,80,30)];
    price.backgroundColor =[UIColor orangeColor];
    price.layer.borderWidth = 1.0;
    price.layer.borderColor =[UIColor grayColor].CGColor;
    price.layer.cornerRadius = 5;
    price.layer.masksToBounds = YES;
    price.center = CGPointMake(imgView.frame.size.width , imgView.frame.origin.y+imgView.frame.size.height -20.0);
    price.tag = 500;
    [imgView addSubview:price];
    
    
    
    [self addSubview:imgView];
    
    for (int i = 0; i < labName.count ; i ++)
    {
        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(edge_distance,CGRectGetMaxY(imgView.frame)+(h_distance + lab_height)*i ,lab_width, lab_height)];
        lab.text = labName[i];
        lab.tag = 1500 +i;
        lab.textAlignment =NSTextAlignmentRight;
        lab.font =[UIFont systemFontOfSize:13.0];
        
        UILabel *desLab =[[UILabel alloc]initWithFrame:CGRectMake(lab_width+edge_distance+5.0,lab.frame.origin.y ,desLab_width ,lab_height )];
        desLab.textAlignment = NSTextAlignmentLeft;
        desLab.font = [UIFont systemFontOfSize:13.0];
        desLab.tag = 2000 + i;
        

        [self addSubview:lab];
        
        [self addSubview:desLab];
    }
    _cellHeight = imgView.frame.size.height + (h_distance + lab_height)*labName.count +10;
    
}
-(void)setModel:(DrugSearchListModel *)model
{
    if (_model != model)
    {
        _model = model;
        UIImageView *img = (UIImageView *)[self viewWithTag:1000];
        
        if (model.img)
        {
            [img setImageWithURL:[NSURL URLWithString:model.img]];
        }
        else
        {
            img.image =[UIImage imageNamed:@"22222.jpg"];
        }
        
        
        
        
        UILabel *preicLab = (UILabel *)[self viewWithTag:500];
        preicLab.text = [NSString stringWithFormat:@"￥:%2f",[model.price floatValue]];
         NSArray *desLabArray = @[@"drugName",@"jj",@"manu",@"pzwh",@"syz",@"yfyl",@"yxq",@"zc",@"zycf"];
        int i = 0;
        for (NSString *str in desLabArray)
        {
            UILabel *lab = (UILabel *)[self viewWithTag:2000 + i];
            lab.text = [model valueForKey:str];
            
            i++;
        }


    }
}

-(void)reloadCellFrame
{
//    CGRect frame = [lab.text boundingRectWithSize:CGSizeMake(lab.bounds.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
//    lab.font = [UIFont systemFontOfSize:13.0];
//    lab.numberOfLines = 0;
//    lab.frame = CGRectMake(lab.frame.origin.x,CGRectGetMaxY(img.frame)+(5.0 * i) + CGRectGetMaxY(lab.frame), lab.frame.size.width, frame.size.height);
//    
//    UILabel *nameLab =(UILabel *)[self viewWithTag:1500 +i];
//    nameLab.frame = CGRectMake(nameLab.frame.origin.x, lab.frame.origin.y, nameLab.frame.size.width, nameLab.frame.size.height);
    
//    UILabel *lab = (UILabel *)[self viewWithTag:1500 + desLabArray.count];
//    
//    _cellHeight = lab.frame.origin.y + lab.frame.size.height + 10.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
