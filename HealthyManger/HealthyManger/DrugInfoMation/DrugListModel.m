//
//  DrugListModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugListModel.h"
#import "MJExtension.h"

@implementation DrugListModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"tngou":@"DrugListDetailsModel"};
}
@end


@implementation DrugListDetailsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"Description":@"description"};
}

@end