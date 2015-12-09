//
//  ARZBarController.h
//  Dota2
//
//  Created by Aaron on 15/9/28.
//  Copyright © 2015年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 使用说明:
 Zbar编译
 需要添加依赖库 AVFoundation  CoreMedia  libiconv CoreVideo QuartzCore
 
 扫码使用代理或者block其中一种即可,两种都写,则会获取数据两次
 
 此控制器需要用导航推出,如果想使用模态切换,需要修改方法
 -(void)back;
 
 界面的修改参考代码注释

 扫描二维码
 block版
 添加头文件 #import "ARZBarController.h"
 ARZBarController *vc = [[ARZBarController alloc] initWithReciveBack:^(NSString *data, BOOL isSuccess) {
 NSLog(@"%@",data);
 }];
 [self.navigationController pushViewController:vc animated:YES];


 生成二维码
 添加头文件 #import "QRCodeGenerator.h"
 imageView.image=[QRCodeGenerator qrImageForString:@"撸啊撸超神了" imageSize:imageView.bounds.size.width];
 */

@protocol ARZBarControllerDelegate <NSObject>
-(void)reciveData:(NSString *)data isSuccess:(BOOL)isSuccess;
@end

@interface ARZBarController : UIViewController
@property (nonatomic,assign) id<ARZBarControllerDelegate> delegate;
-(instancetype)initWithReciveBack:(void (^)(NSString *data, BOOL isSuccess))reciveBack;
@end
