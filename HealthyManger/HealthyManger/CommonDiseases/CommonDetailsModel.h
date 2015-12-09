//
//  CommonDetailsModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDetailsModel : NSObject
@property (nonatomic,copy)NSString *showapi_res_code;
@property (nonatomic,copy)NSString *showapi_res_error;
@property (nonatomic,copy)NSArray *contentlist;
@end


@interface CommonDetailsContentList : NSObject
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *subTypeId;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *subTypeName;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *name;
@end