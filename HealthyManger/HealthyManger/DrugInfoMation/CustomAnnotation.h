//
//  CustomAnnotation.h
//  App地图
//
//  Created by qianfeng on 15/11/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
// 自定义大头针,需要定义大头针数据
@interface CustomAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D Coordinate;
}
//@property (nonatomic,readonly)CLLocationCoordinate2D Coordinate;

@property (nonatomic,copy)NSString *anontationTitle;

@property (nonatomic,copy)NSString *anontationSubTitle;

-(id)initAnnotation:(CLLocationCoordinate2D)coordinate;

@end
