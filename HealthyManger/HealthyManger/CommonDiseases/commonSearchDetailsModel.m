//
//  commonSearchDetailsModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "commonSearchDetailsModel.h"

#import "MJExtension.h"

@implementation commonSearchDetailsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"tagList":@"showapi_res_body.item.tagList"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"tagList":@"commonSearchDetailsTagList"};
}
@end


@implementation commonSearchDetailsTagList



@end