//
//  CommonModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommonModel : NSObject
@property (nonatomic,copy)NSString *showapi_res_code;
@property (nonatomic,copy)NSString *showapi_res_error;
@property (nonatomic,strong)NSArray *list;
@end


@interface CommonListModel : NSObject
@property (nonatomic,copy)NSString *typeId;
@property (nonatomic,copy)NSString *typeName;
@property (nonatomic,strong)NSArray *subList;
@end


@interface CommonSubModel : NSObject
@property (nonatomic,copy)NSString *subId;
@property (nonatomic,copy)NSString *subName;

@end