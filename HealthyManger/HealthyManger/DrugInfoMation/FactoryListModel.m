//
//  FactoryListModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FactoryListModel.h"
#import "MJExtension.h"

@implementation FactoryListModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"tngou":@"FactoryListInfoModel"};
}

@end


@implementation FactoryListInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end