//
//  DBManager.h
//  数据库的封装
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

// 使用说明,使用此工具需配合fmdb三方库使用


@interface DBManager : NSObject
// 单例方法
+(instancetype)sharedDBManager;
// 新一条数据
-(BOOL)insertDataWithDictionary:(NSDictionary *)dataDic;
// 删除一条数据
-(BOOL)deleteDataWithDictionary:(NSDictionary *)dataDic;
// 修改一条数据
-(BOOL)changeDataWithDictionary:(NSDictionary *)dataDic;
// 查询数据
-(BOOL)searchOneDataWithDictionary:(NSDictionary *)dataDic;
// 查询所有数据
-(NSArray *)recieveDBData;

@end
