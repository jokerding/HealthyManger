//
//  DrugClassModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DrugClassModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, strong) NSNumber *drugclass;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *seq;
@end



