//
//  DrugListModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugListModel : NSObject

@property (nonatomic,copy)NSString *totol;
@property (nonatomic,strong)NSArray *tngou;

@end


@interface DrugListDetailsModel : NSObject

@property (nonatomic, strong) NSNumber *fcount;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, strong) NSNumber *rcount;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;

@end