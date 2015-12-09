//
//  CustomAnnotationView.m
//  App地图
//
//  Created by qianfeng on 15/11/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        self.annotationInfo = annotation;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
