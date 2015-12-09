//
//  CustomAnnotationView.h
//  App地图
//
//  Created by qianfeng on 15/11/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"

@interface CustomAnnotationView : MKAnnotationView
// 自定义大头针 需要自定义一个大头针的坐标
@property (nonatomic,strong)CustomAnnotation *annotationInfo;
@end
