//
//  CommonModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommonModel.h"
#import "MJExtension.h"
@implementation CommonModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"list":@"showapi_res_body.list"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"list":@"CommonListModel"};
}
@end

@implementation CommonListModel
//+(NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"subList":@"list.subList"};
//}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"subList":@"CommonSubModel"};
}
@end

@implementation CommonSubModel




@end
