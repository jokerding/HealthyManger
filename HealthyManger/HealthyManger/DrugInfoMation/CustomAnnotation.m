//
//  CustomAnnotation.m
//  App地图
//
//  Created by qianfeng on 15/11/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

-(id)initAnnotation:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        Coordinate = coordinate;
        
    }
    return self;
}

// 重写了自定义大头针的数据层的方法
// 重写以下三个方法,才能正常显示自定义大头针
-(CLLocationCoordinate2D)coordinate
{
    return Coordinate;
}

-(NSString *)title
{
    return self.anontationTitle;
}

-(NSString *)subtitle
{
    return self.anontationSubTitle;
}
@end
