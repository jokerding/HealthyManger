//
//  DrugSearchModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugSearchModel : NSObject
@property (nonatomic,copy)NSString *totol;
@property (nonatomic,strong)NSArray *tngou;
@end

@interface DrugSearchListModel : NSObject

@property (nonatomic, copy) NSString *Description;
@property (nonatomic, strong) NSNumber *fcount;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *rcount;

@end
