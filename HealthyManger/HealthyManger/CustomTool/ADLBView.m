//
//  ADLBView.m
//  day-15-02-广告轮播方法封装
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ADLBView.h"

@interface ADLBView()<UIScrollViewDelegate>
// 创建一个私有属性并遵循滚动视图的代理
@property (nonatomic,strong) UIScrollView *adView;
// 提供一个属性将滚动视图记录下来
@property (nonatomic,strong) NSArray *images;
// 记录广告图片信息
@property (nonatomic,strong) NSMutableArray *imageViewS;
// 记录广告图片显示的视图信息
@property (nonatomic,assign) NSInteger currentIndex;
// 记录当前页面的下标
@property (nonatomic,strong) NSMutableArray *btnArray;
// 记录显示页面下标的信息按钮
@property (nonatomic,strong) NSTimer *timer;
// 创建记时器
@property (nonatomic,strong)void(^callBack)(NSInteger chooseIndex);
// 记录带参数的block
@property (nonatomic,strong)UIPageControl *pageControl;
// 记录调用方法的状态
@property (nonatomic,assign)BOOL isPageControl;

@end

@implementation ADLBView

#pragma mard -- 初始化方法重写
// frame 位置与大小
// images 传入的图片信息
// callBack 传入的blcok代码块
#pragma mark -- 带数字和删除按钮的初始化方式
-(instancetype)initWithFrame:(CGRect)frame WhitIamges:(NSArray *)images WithCallBack:(void(^)(NSInteger chooseIndex))callBack
{
    if (self =[super initWithFrame:frame])
    {
        _images = images;
        _callBack = callBack;
        [self configUIforBtn]; // 配置界面
        [self createNumberBtnAndDelBtn];// 配置按钮显示图片下标及状态
        [self autoStartScrollView]; // 自动滚动视图
        _isPageControl = NO;
        
    }
    return self;
}

#pragma mark -- 小圆点初始化方式
-(instancetype)initWithFrame:(CGRect)frame WhitIamges:(NSArray *)images WithPageControllCallBack:(void (^)(NSInteger chooseIndex))callBack;
{
    if (self =[super initWithFrame:frame])
    {
        _images = images;
        _callBack = callBack;
        
        [self configUIforPageControl];

        [self autoStartScrollView]; // 自动滚动视图
        
        _isPageControl = YES;
        
    }
    return self;
}

#pragma mark -- 创建滚动视图\图片显示视图\广告页数显示方式
-(void)configUIforBtn
{
#pragma mark -- 填加手势
    // 创建点击手势,用于点击广告页面
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOne:)];
    // 将手势填加到视图上
    [self addGestureRecognizer:tap];
#pragma mark -- 创建滚动视图
    // 创建滚动视图,将滚动视图显示的大小与视图大小一致
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:self.bounds];
    // 将滚动视图处填加到自己(视图)上
    [self addSubview:scrollView];
    // 设置滚动视图的背景颜色
    scrollView.backgroundColor = [UIColor whiteColor];
    // 将滚动视图使用属性保存下来
    _adView = scrollView;
#pragma mark-- 创建图片显示视图
    // 初始化图片显示视图容器
    _imageViewS = [NSMutableArray array];
    // 创建三个图片显示视图
    for (int i = 0; i < 3; i++)
    {
        UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(scrollView.bounds.size.width*i,0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        // 将图片视图填加到滚动视图上
        [scrollView addSubview:imgView];
        // 将图片视图填加到视图容器中
        [_imageViewS addObject:imgView];
    }
#pragma mark -- 设置滚动视图相关属性
    // 设置关闭回弹
    scrollView.bounces = NO;
    // 设置关闭滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置画布大小
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width *3, scrollView.bounds.size.height);
    // 设置默认显示的视图(中间) 视图顺序为: 0 1 2 显示1的位置
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    // 打开滚动视图分页效果
    scrollView.pagingEnabled = YES;
    // 设置代理
    scrollView.delegate = self;
    
    // 显示广告图片  将当前下标传给方法 0
    [self showImageByIndex:_currentIndex];
}

#pragma mark -- 创建滚动视图\小圆点方式
-(void)configUIforPageControl
{
#pragma mark -- 填加手势
    // 创建点击手势,用于点击广告页面
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOne:)];
    // 将手势填加到视图上
    [self addGestureRecognizer:tap];
#pragma mark -- 创建滚动视图
    // 创建滚动视图,将滚动视图显示的大小与视图大小一致
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:self.bounds];
    // 将滚动视图处填加到自己(视图)上
    [self addSubview:scrollView];
    // 设置滚动视图的背景颜色
    scrollView.backgroundColor = [UIColor whiteColor];
    // 将滚动视图使用属性保存下来
    _adView = scrollView;
#pragma mark-- 创建图片显示视图
    // 初始化图片显示视图容器
    _imageViewS = [NSMutableArray array];
    // 创建三个图片显示视图
    for (int i = 0; i < 3; i++)
    {
        UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(scrollView.bounds.size.width*i,0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        // 将图片视图填加到滚动视图上
        [scrollView addSubview:imgView];
        // 将图片视图填加到视图容器中
        [_imageViewS addObject:imgView];
    }
#pragma mark -- 设置滚动视图相关属性
    // 设置关闭回弹
    scrollView.bounces = NO;
    // 设置关闭滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置画布大小
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width *3, scrollView.bounds.size.height);
    // 设置默认显示的视图(中间) 视图顺序为: 0 1 2 显示1的位置
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    // 打开滚动视图分页效果
    scrollView.pagingEnabled = YES;
    // 设置代理
    scrollView.delegate = self;
    
    [self createPageControlWithNumberOfPage:_images.count AndCurrentPage:_currentIndex];
    
    [self addSubview:_pageControl];
    
    // 显示广告图片  将当前下标传给方法 0
    [self showImageByIndex:_currentIndex];
}

#pragma mark -- 创建小圆点滚动视图
-(void)createPageControlWithNumberOfPage:(NSInteger)number AndCurrentPage:(NSInteger)currentIndex;
{
    // 初始化对象
    _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0,self.bounds.size.height-30,self.bounds.size.width, 30)];
    // 设置页数(小圆点数量)
    _pageControl.numberOfPages = number;
    // 设置非当前页小圆点颜色
    _pageControl.pageIndicatorTintColor =[UIColor orangeColor];
    // 设当前页小圆点颜色
    _pageControl.currentPageIndicatorTintColor =[UIColor greenColor];
    // 设置小圆点滚动
    
    //_pageControl.currentPage = currentIndex;
    [self addSubview:_pageControl];
 }


#pragma mark -- 回传手势点击事件的数据(当前图片下标)
-(void)chooseOne:(UITapGestureRecognizer *)tap
{
    // 调用初始化中的代码块方法,将选中的页面下标参数传出,以利于调用者的接收
    _callBack(_currentIndex);
}

#pragma mark -- 实现代理方法 视图回弹结束后的事件处理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 将当前视图的相对坐标记录下来
    CGPoint contentOffset = scrollView.contentOffset;
    if (contentOffset.x == 0)  //到最左边的时候
    {
        // 将视图下标进行交换
        _currentIndex =[self trueIndexFromIndex:_currentIndex-1];
       // NSLog(@"%ld",_currentIndex);
    }
    else if (contentOffset.x == scrollView.bounds.size.width *2) // 到最右
    {
        //将视图下标进行交换
        _currentIndex =[self trueIndexFromIndex:_currentIndex+1];
       // NSLog(@"%ld",_currentIndex);
    }
    // 图片下标交换后,显示交换后下标的图片
    [self showImageByIndex:_currentIndex];
    // 图片显示的相对坐标换到中间(让图片居中显示) 始终居中显示
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    
    if (_isPageControl)
    {
        // 如果使用小圆点方式需要增加这个赋值
        _pageControl.currentPage = _currentIndex;;
    }
    else if (!_isPageControl)
    {
        // 如果使用小圆点方式显示的时候,此方法须禁用
        // 调用按钮显示
        [self changePageImageByIndex:_currentIndex];
    }
  
  
}

#pragma mark -- 图片下标位置交换
-(NSInteger)trueIndexFromIndex:(NSInteger)index  // 这个地方传入的参数为下面的方法传入的数字
{
    if (index == -1)  //如果视图到最左边
    {
        return _images.count-1; //图片应该选择最后一张
    }
    else if (index == _images.count) // 如果超过图片数组最大值
    {
        return 0;  //图片返回到第一张
    }
    return index;  //如果传入的值是0,则选择对应的图片也是0
 
}

#pragma mark -- 根据交换的下标更换显示的图片
-(void)showImageByIndex:(NSInteger)index  //0
{
    for (int i = -1; i<=1 ; i++) // 通过这个循环让三个视图对应三个图片
    {
        UIImageView *imgView = _imageViewS[i+1]; // 视图是0
        imgView.image = _images[[self trueIndexFromIndex:index+i]];// 图片是最后一张
    }
    // 传入的数据 0 第一次循环 视图为0(左边) 图片为最后一张
    // 第二次循环 视图为1(中间) 图片为第一张
    // 第三次循环 视图为2(右边) 图片为第二张
}

#pragma mark -- 创建分页标识


#pragma mark -- 创建视图对应的下标数字或删除按钮
-(void)createNumberBtnAndDelBtn
{
    _btnArray =[NSMutableArray array];// 初始化容器
    for (int i = 0; i <=_images.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i !=_images.count) // 将最后一个删除按钮单独创建
        {
            [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            btn.titleLabel.font =[UIFont systemFontOfSize:8];
            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_n"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO; // 关闭用户交互事件
        }
        else
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_del.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(dismissMe:) forControlEvents:UIControlEventTouchUpInside];// 绑定点击事件
        }
        [self addSubview:btn];
        [_btnArray addObject:btn];// 将创建的按钮装入数组
    }
    //NSLog(@"进入!");
    [self reloadBtn];// 刷新按钮位置
    [self changePageImageByIndex:_currentIndex];//改变按钮的显示文字内容及状态
    
}

#pragma mark -- 刷新按钮位置(根据边栏尺寸)
-(void)reloadBtn
{
    for (int i = 0; i<_btnArray.count; i++)
    {
        UIButton *btn = _btnArray[_btnArray.count-1-i];
        btn.frame = CGRectMake(self.bounds.size.width-_boardWidth.right-30-15*i, self.bounds.size.height - _boardWidth.bottom-20, 10, 10);
    }
}

#pragma mark -- 根据图片下标更换按钮上文字
-(void)changePageImageByIndex:(NSInteger)index
{
    NSInteger j = index;
    NSLog(@"%ld",j);
    for (int i = 0; i< _btnArray.count-1; i++)
    {
        UIButton *btn = _btnArray[i];
        if (i == index)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_h"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //NSLog(@"高亮");
        }
        else
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_n"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //NSLog(@"普通");
        }
    }
}
#pragma mark -- 点击删除按钮事件
-(void)dismissMe:(UIButton *)sender
{
    [self removeFromSuperview];
}


#pragma mark -- 创建自动滚动
// 创建定时器
-(void)autoStartScrollView
{
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    }
}

-(void)timeRun
{
    // 第一步更换滚动视图相对坐标
    // 结束后更改图片位置
    [UIView animateWithDuration:1 animations:^{
        _adView.contentOffset = CGPointMake(_adView.bounds.size.width*2, 0);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:_adView];
    }];
}


#pragma mark -- 重写setter方法
-(void)setBoardWidth:(UIEdgeInsets)boardWidth
{
    _boardWidth = boardWidth;
    
    //  设置增加边框后的广告滚动视图的尺寸
    _adView.frame = CGRectMake(_boardWidth.left, _boardWidth.top, self.bounds.size.width-_boardWidth.left-_boardWidth.right, self.bounds.size.height-_boardWidth.bottom-_boardWidth.top);
    // 重新创建滚动视图
    for (int i = 0; i < _imageViewS.count; i++)
    {
        UIImageView *imgView = _imageViewS[i];
        imgView.frame = CGRectMake(_adView.bounds.size.width*i, 0, _adView.bounds.size.width, _adView.bounds.size.height);
    }
    // 设置画布的偏移量(相对坐标) 参照新的滚动视图  居中显示
    _adView.contentOffset = CGPointMake(_adView.bounds.size.width, 0);
    // 重新设置画布大小
    _adView.contentSize = CGSizeMake(_adView.bounds.size.width *3, _adView.bounds.size.height);
}
// 重写边栏颜色方法
-(void)setBoardColer:(UIColor *)boardColer
{
    _boardColer = boardColer;
    self.backgroundColor = _boardColer;
}

@end
