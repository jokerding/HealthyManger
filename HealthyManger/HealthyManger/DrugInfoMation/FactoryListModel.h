//
//  FactoryListModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactoryListModel : NSObject
@property (nonatomic,copy)NSString *total;
@property (nonatomic,strong)NSArray *tngou;
@end


@interface FactoryListInfoModel : NSObject

@property (nonatomic, copy) NSString *classcode;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, copy) NSString *legal;
@property (nonatomic, copy) NSString *paddress;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *fcount;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, strong) NSNumber *rcount;
@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;
@property (nonatomic, strong) NSNumber *area;
@property (nonatomic, strong) NSNumber *createdate;
@property (nonatomic, copy) NSString *charge;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *raddress;

@end