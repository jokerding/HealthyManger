//
//  FactoryListInfoCell.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FactoryListInfoCell.h"
#import "UIImageView+AFNetworking.h"
@implementation FactoryListInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
//    _FactoryAdds =[[UILabel alloc]initWithFrame:CGRectMake(_FactoryLogo.frame.origin.x, CGRectGetMaxY(_FactoryHttp.frame)+10.0, self.frame.size.width -20.0, 100.0)];
//    
//    [self addSubview:_FactoryAdds];
}


-(void)setModel:(FactoryListInfoModel *)model
{
    if (_model != model)
    {
        _model = model;
        NSString *imgUrl =[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",model.img];
        
        [_FactoryLogo setImageWithURL:[NSURL URLWithString:imgUrl]];
        _FactoryName.text = model.name;
        _FactoryTel.text = model.tel;
        _FactoryHttp.text = model.url;
        _FactoryAdds.text = model.address;
   
        
        CGRect bounds = [model.address boundingRectWithSize:CGSizeMake(_FactoryAdds.bounds.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
        
        _FactoryAdds.font =[UIFont systemFontOfSize:14.0];
        _FactoryAdds.numberOfLines = 0;
        _FactoryAdds.frame = CGRectMake(_FactoryAdds.frame.origin.x, _FactoryAdds.frame.origin.y, _FactoryAdds.frame.size.width, bounds.size.height);
        
        _cellHeight = CGRectGetMaxY(_FactoryAdds.frame)+10.0;
        
    
    }
}
@end
