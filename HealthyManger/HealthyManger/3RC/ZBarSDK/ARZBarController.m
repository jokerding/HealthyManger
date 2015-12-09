//
//  ARZBarController.m
//  Dota2
//
//  Created by Aaron on 15/9/28.
//  Copyright © 2015年 Aaron. All rights reserved.
//

#import "ARZBarController.h"
#import "ZBarSDK.h"

#ifndef SCREEN_WIDTH_POINT
#define SCREEN_WIDTH_POINT ([[UIScreen mainScreen] bounds].size.width/375)
#endif

#ifndef SCREEN_HEIGHT_POINT
#define SCREEN_HEIGHT_POINT ([[UIScreen mainScreen] bounds].size.height/667)
#endif


@interface ARZBarController ()<ZBarReaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) ZBarReaderView *readerView;
@property (nonatomic,strong) ZBarCameraSimulator *cameraSimulator;
@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,copy) void (^backBlock)(NSString *, BOOL);
@end

@implementation ARZBarController
-(instancetype)initWithReciveBack:(void (^)(NSString *, BOOL))reciveBack
{
    if(self = [super init])
    {
        self.backBlock = reciveBack;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self configNav];
    [self configSMZone];
    [self configBottomBar];
}

#pragma mark -- 配置导航
-(void)configNav
{
    //假导航
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375*SCREEN_WIDTH_POINT, 64*SCREEN_HEIGHT_POINT)];
    navView.backgroundColor = [UIColor colorWithRed:0.184 green:0.545 blue:0.388 alpha:1.000];
    [self.view addSubview:navView];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20*SCREEN_WIDTH_POINT, 22*SCREEN_HEIGHT_POINT, 40*SCREEN_WIDTH_POINT, 40*SCREEN_WIDTH_POINT);
    [backBtn setImage:[UIImage imageNamed:@"navi_btn_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];

    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200*SCREEN_WIDTH_POINT, 44*SCREEN_HEIGHT_POINT)];
    titleLab.center = CGPointMake(375*SCREEN_WIDTH_POINT/2, (20+22)*SCREEN_HEIGHT_POINT);
    titleLab.text = @"条码扫描";
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLab];
}

#pragma mark -- 返回原来的界面
-(void)back
{
    [self timerStop];
    _readerView.torchMode = 0;
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -- 配置扫描界面
-(void)configUI
{
    self.view.backgroundColor = [UIColor whiteColor];

    //加载照相区域
    self.readerView = [[ZBarReaderView alloc] init];
    //设置照片大小
    self.readerView.frame = CGRectMake(0, 0, 375*SCREEN_WIDTH_POINT, 667*SCREEN_WIDTH_POINT);
    [self.view addSubview:self.readerView];
    //模拟器调试
    if(TARGET_IPHONE_SIMULATOR)
    {
        _cameraSimulator = [[ZBarCameraSimulator alloc] initWithViewController:self];
        _cameraSimulator.readerView = _readerView;
    }
    //设置代理
    self.readerView.readerDelegate = self;
    //关闭闪光灯
    self.readerView.torchMode = 0;
    //设定扫描区域
    self.readerView.scanCrop = [self getScanCropWithScanRect:CGRectMake(50*SCREEN_WIDTH_POINT, 170*SCREEN_HEIGHT_POINT, 275*SCREEN_WIDTH_POINT, 275*SCREEN_WIDTH_POINT) andReaderViewBounds:self.readerView.bounds];
    //设定不显示对齐框
    self.readerView.tracksSymbols = NO;
    //打开摄像头
    [self.readerView start];

}

#pragma mark -- 配置未扫描边框区域
-(void)configSMZone
{
    //布置未扫描区域
    //扫描区域顶部
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64*SCREEN_HEIGHT_POINT, 375*SCREEN_WIDTH_POINT, 106*SCREEN_HEIGHT_POINT)];
    topView.backgroundColor = [UIColor colorWithRed:0.184 green:0.545 blue:0.388 alpha:1.000];
    [self.view addSubview:topView];

    //左侧
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 170*SCREEN_HEIGHT_POINT, 50*SCREEN_WIDTH_POINT, 275*SCREEN_HEIGHT_POINT)];
    leftView.backgroundColor = [UIColor colorWithRed:0.184 green:0.545 blue:0.388 alpha:1.000];    [self.view addSubview:leftView];

    //右侧
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(325*SCREEN_WIDTH_POINT, 170*SCREEN_HEIGHT_POINT, 50*SCREEN_WIDTH_POINT, 275*SCREEN_HEIGHT_POINT)];
    rightView.backgroundColor = [UIColor colorWithRed:0.184 green:0.545 blue:0.388 alpha:1.000];    [self.view addSubview:rightView];

    //底部
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(rightView.frame), 375*SCREEN_WIDTH_POINT,667*SCREEN_HEIGHT_POINT-CGRectGetMaxY(rightView.frame))];
    bottomView.backgroundColor = [UIColor colorWithRed:0.184 green:0.545 blue:0.388 alpha:1.000];    [self.view addSubview:bottomView];

    //说明信息
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rightView.frame), 375*SCREEN_WIDTH_POINT, 30*SCREEN_HEIGHT_POINT)];
    infoLab.text = @"请将二维码对准方框,即可自动扫描";
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.textColor = [UIColor whiteColor];
    [self.view addSubview:infoLab];

    //扫描线条
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50*SCREEN_WIDTH_POINT, 170*SCREEN_HEIGHT_POINT, 275*SCREEN_WIDTH_POINT, 3*SCREEN_HEIGHT_POINT)];
    _line.image = [UIImage imageNamed:@"qrcode_scan_light_green"];
    [self.view addSubview:_line];

    //线条开始扫动
    [self startSM];
}

#pragma mark -- 配置底部工具
-(void)configBottomBar
{
    CGFloat width = SCREEN_HEIGHT_POINT>SCREEN_WIDTH_POINT?SCREEN_WIDTH_POINT:SCREEN_HEIGHT_POINT;
    //底部工具条
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    photoBtn.frame = CGRectMake(50*SCREEN_WIDTH_POINT, 550*SCREEN_HEIGHT_POINT, 100*width, 100*width);
    [photoBtn addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoBtn];


    UIButton *lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lightBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [lightBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateHighlighted];
    lightBtn.frame = CGRectMake(225*SCREEN_WIDTH_POINT, 550*SCREEN_HEIGHT_POINT, 100*width, 100*width);
    lightBtn.tag = 0;
    [lightBtn addTarget:self action:@selector(lightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightBtn];
}

#pragma mark -- 底部按钮事件
#pragma mark 开闪光灯
-(void)lightBtnClick:(UIButton *)sender
{
    if(sender.tag == 0)
    {
        [sender setImage:[UIImage imageNamed:@"qrcode_scan_btn_scan_off"] forState:UIControlStateNormal];
        _readerView.torchMode = 1;
        sender.tag = 1;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
        _readerView.torchMode = 0;
        sender.tag = 0;
    }
}

#pragma mark 扫描照片
//照片选择
-(void)chooseImage
{
    //用zbar自带的imagePicker选择照片
    ZBarReaderController *imagePicker = [[ZBarReaderController alloc] init];
    //设置导航颜色
    imagePicker.navigationBar.barTintColor = [UIColor colorWithRed:0.470 green:0.934 blue:1.000 alpha:1.000];
    imagePicker.navigationBar.translucent = NO;
    //设置文字颜色
    imagePicker.navigationBar.tintColor = [UIColor whiteColor];
    //设置数据源
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark imagePicker代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    for(ZBarSymbol *symbol in info[ZBarReaderControllerResults])
    {
        NSString *data = nil;
        //将日文编码转成UTF8,解决部分中文乱码
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])

        {
            data = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            data = symbol.data;
        }
        NSLog(@"%@",data);
        if(_backBlock)
        {
            self.backBlock(data,YES);
        }
        else if(_delegate)
        {
            [_delegate reciveData:data isSuccess:YES];
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self showAlert];
    }];
}

-(void)showAlert
{
    //制作处理假象
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(120*SCREEN_WIDTH_POINT, 280*SCREEN_HEIGHT_POINT, 275*SCREEN_WIDTH_POINT, 50*SCREEN_HEIGHT_POINT)];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor colorWithRed:0.991 green:0.069 blue:0.060 alpha:1.000];
    indicator.frame = CGRectMake(20*SCREEN_WIDTH_POINT, 15*SCREEN_HEIGHT_POINT, 20*SCREEN_HEIGHT_POINT, 20*SCREEN_HEIGHT_POINT);
    [indicator startAnimating];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_WIDTH_POINT+20*SCREEN_HEIGHT_POINT, 10*SCREEN_HEIGHT_POINT, 100*SCREEN_HEIGHT_POINT, 30*SCREEN_HEIGHT_POINT)];
    lab.text = @"正在处理中";
    lab.textColor = [UIColor colorWithRed:0.991 green:0.069 blue:0.060 alpha:1.000];
    [view addSubview:indicator];
    [view addSubview:lab];
    [self.view addSubview:view];

    //停掉扫描条
    [self timerStop];

    [self performSelector:@selector(removeAlert:) withObject:view afterDelay:1];
}

-(void)removeAlert:(UIView *)view
{
    [view removeFromSuperview];
    [self back];
}

#pragma mark -- ZBarReaderView代理
- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image
{
    for(ZBarSymbol *symbol in symbols)
    {
        NSString *data = nil;
        //将日文编码转成UTF8,解决部分中文乱码
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
        {
            data = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            data = symbol.data;
        }
        NSLog(@"%@",data);
        if(_backBlock)
        {
            self.backBlock(data,YES);
        }
        else if(_delegate)
        {
            [_delegate reciveData:data isSuccess:YES];
        }
        [self showAlert];
    }
}

#pragma mark -- 开始扫描
-(void)startSM
{
    if(!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
        //显示线条
        _line.hidden = NO;
    }
}

//调整扫描条
-(void)timerRun:(id)sender
{
    static int isDown = 1;
    CGRect frame = _line.frame;
    if(isDown)
    {
        frame.origin.y+=2.5;
        if(frame.origin.y > (170+275)*SCREEN_HEIGHT_POINT)
        {
            frame.origin.y-=5;
            isDown = NO;
        }
    }
    else
    {
        frame.origin.y-=2.5;
        if(frame.origin.y < 170*SCREEN_HEIGHT_POINT)
        {
            frame.origin.y+=5;
            isDown = YES;
        }
    }
    _line.frame = frame;
}

-(void)timerStop
{
    if(_timer)
    {
        [_timer invalidate];
        _timer = nil;
        //不显示线条
        _line.hidden = YES;
    }
}

#pragma mark -- 计算扫描区域
- (CGRect)getScanCropWithScanRect:(CGRect)rect andReaderViewBounds:(CGRect)rvBounds
{
    CGFloat x,y,width,height;

    x = rect.origin.y / rvBounds.size.height;
    y = 1 - (rect.origin.x + rect.size.width) / rvBounds.size.width;
    width = rect.size.height / rvBounds.size.height;
    height = rect.size.width / rvBounds.size.width;

    return CGRectMake(x, y, width, height);
    
}

//定制状态栏风格
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
