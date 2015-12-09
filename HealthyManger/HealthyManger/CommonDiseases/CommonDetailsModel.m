//
//  CommonDetailsModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommonDetailsModel.h"
#import "MJExtension.h"

@implementation CommonDetailsModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"contentlist":@"showapi_res_body.pagebean.contentlist"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"contentlist":@"CommonDetailsContentList"};
}

@end

@implementation CommonDetailsContentList

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end