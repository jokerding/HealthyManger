//
//  DBManager.m
//  数据库的封装
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
static DBManager *_db;
@implementation DBManager
{
    FMDatabase *_fmdb;
}

// 创建单例
+(instancetype)sharedDBManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!_db)
        {
            _db =[[DBManager alloc]init];
        }
    });
    return _db;
}

// 创建数据库
-(instancetype)init
{
    if (self = [super init])
    {
        // 初化化数据的时候,我们需要给数据库一个沙盒数径进行永久保存,存储在Doucments目录下
        NSString *path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/appsb.db"];
        
        NSLog(@"%@",path);
        // 创建数据库,通过接收一个路径来创建数据库
        _fmdb =[FMDatabase databaseWithPath:path];
        
        BOOL isSuccess = [_fmdb open];
        // 判断数据库是否创建成功
        if (isSuccess)
        {
            NSString * sql = @"create table if not exists appdsb(applicationId varchar(32),name varchar(128),iconurl varchar(1024))";
            
            BOOL tableSuccedd = [_fmdb executeUpdate:sql];
            
            if (tableSuccedd)
            {
                NSLog(@"表格创建成功");
            }
            else
            {
                NSLog(@"表格创建失败");
            }
            NSLog(@"数据库创建成功");
        }
        else
        {
            NSLog(@"%@",_fmdb.lastErrorMessage);
        }
    }
    return  self;
}

// 插入一条数据
-(BOOL)insertDataWithDictionary:(NSDictionary *)dataDic
{
    /*增insert into 表名 (applicationId,name,iconUrl) values (?,?,?)*/
    NSString *sql = @"insert into appdsb (applicationId,name,iconurl) values (?,?,?)";
    
    BOOL success = [_fmdb executeUpdate:sql,dataDic[@"applicationId"],dataDic[@"name"],dataDic[@"iconUrl"]];
    if (success)
    {
        NSLog(@"插入成功");
    }
    else
    {
        NSLog(@"插入失败:%@",_fmdb.lastErrorMessage);
    }
    
    return success;
}


// 删除一条数据
-(BOOL)deleteDataWithDictionary:(NSDictionary *)dataDic
{
    /*删delete from 表名 where applicationId = ?*/
    NSString *sql = @"delete from appdsb where applicationId = ?";
    
    BOOL success = [_fmdb executeUpdate:sql,dataDic[@"appID"]];
    if (success)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失改:%@",_fmdb.lastErrorMessage);
    }
    
    return success;
}

// 修改数据
-(BOOL)changeDataWithDictionary:(NSDictionary *)dataDic
{
    /*改  update 表名 set 属性名 = ? where applicationId = ?*/
    NSString *sql = @"update appdsb set name = ? where applicationId = ?";
    
    BOOL success =[_fmdb executeUpdate:sql,dataDic[@"name"],dataDic[@"appID"]];
    
    if (success)
    {
        NSLog(@"修改成功");
    }
    else
    {
        NSLog(@"修改失败:%@",_fmdb.lastErrorMessage);
    }
    return success;
}

// 查询数据
-(BOOL)searchOneDataWithDictionary:(NSDictionary *)dataDic
{
    /*查询某一个是否存在select applicationId from 表名 where applicationId = ?*/
    NSString *sql = @"select applicationId from appdsb where applicationId = ?";
    FMResultSet *set = [_fmdb executeQuery:sql,dataDic[@"appID"]];
    // 查找下一个
    BOOL success = [set next];
    if (success)
    {
        NSLog(@"查询成功");
    }
    else
    {
        NSLog(@"查询失改:%@",_fmdb.lastErrorMessage);
    }
    return success;
}

// 查询所有数据
-(NSArray *)recieveDBData
{
    /* 查询所有的数据select * from 表名 */
    NSString *sql = @"select * from appdsb" ;
    FMResultSet *set = [_fmdb executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray array];
    while ([set next])
    {
        NSDictionary *dic = [set resultDictionary];
        [array addObject:dic];
    }
    return array;
}
@end
