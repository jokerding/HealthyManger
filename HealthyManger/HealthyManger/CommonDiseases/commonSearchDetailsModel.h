//
//  commonSearchDetailsModel.h
//  HealthyManger
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commonSearchDetailsModel : NSObject
@property (nonatomic, strong) NSNumber *showapi_res_code;
@property (nonatomic, copy) NSString *showapi_res_error;
@property (nonatomic,strong)NSArray *tagList;
@end

@interface commonSearchDetailsTagList : NSObject
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)BOOL isOpenGroup;
@property (nonatomic,assign) float cellHeight;
@end