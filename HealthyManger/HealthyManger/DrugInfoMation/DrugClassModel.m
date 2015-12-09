//
//  DrugClassModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugClassModel.h"
#import "MJExtension.h"
@implementation DrugClassModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"Description":@"description"};
}


@end

