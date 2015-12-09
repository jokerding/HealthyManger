//
//  DrugCodeModel.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DrugCodeModel.h"
#import "MJExtension.h"
@implementation DrugCodeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"Description":@"description"};
}

@end
