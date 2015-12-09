//
//  DrugSearchModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugSearchModel.h"
#import "MJExtension.h"
@implementation DrugSearchModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"tngou":@"DrugSearchListModel"};
}

@end

@implementation DrugSearchListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"Description":@"description"};
}


@end