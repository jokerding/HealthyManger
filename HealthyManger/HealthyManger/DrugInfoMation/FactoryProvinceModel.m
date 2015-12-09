//
//  FactoryProvinceModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FactoryProvinceModel.h"
#import "MJExtension.h"

@implementation FactoryProvinceModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
