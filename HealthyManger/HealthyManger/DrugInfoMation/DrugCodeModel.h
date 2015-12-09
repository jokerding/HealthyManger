//
//  DrugCodeModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugCodeModel : NSObject
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, strong) NSNumber *fcount;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, copy) NSString *factory;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *rcount;
@end
