//
//  subCollctionView.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "subCollctionView.h"
#import "SubCollectionViewCell.h"
#import "CommonDetailsViewController.h"

#import "HeaderCollectionReusableView.h"

#import "CommonModel.h"

@interface subCollctionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray *subList;
@property (nonatomic,copy)NSString *subTitle;
@property (nonatomic,copy)NSString *typeId;

@end

@implementation subCollctionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _subList =[NSMutableArray array];
        //NSLog(@".......");
        //self.backgroundColor = [UIColor greenColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)createCollectionWithArray:(NSArray *)array andSubTitle:(NSString *)subTitle andTypeId:(NSString *)typeId
{
    CGFloat distance = 10.0;
    CGFloat width = (self.frame.size.width-distance*5.0)/4.0;
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(width,20.0);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.width, 30);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectonView =[[UICollectionView alloc]initWithFrame:CGRectMake(10.0, 0, self.frame.size.width-20.0, self.frame.size.height) collectionViewLayout:flowLayout];
    collectonView.delegate = self;
    collectonView.dataSource = self;
    collectonView.backgroundColor =[UIColor whiteColor];
    
    UINib *nib =[UINib nibWithNibName:@"SubCollectionViewCell" bundle:nil];
    [collectonView registerNib:nib forCellWithReuseIdentifier:@"SubCollectionViewCell"];
    
    nib =[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil];
    [collectonView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView"];
    
    _subTitle = subTitle;
    _typeId = typeId;
    
    [self addSubview:collectonView];
    _subList =[array mutableCopy];
   
    //NSLog(@"%@",_subList);

    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _subList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubCollectionViewCell" forIndexPath:indexPath];
    CommonSubModel *model = _subList[indexPath.row];
    cell.subName.font =[UIFont systemFontOfSize:12];
    cell.subName.layer.borderWidth = 1.0;
    cell.subName.layer.borderColor =[UIColor blackColor].CGColor;
    cell.subName.layer.cornerRadius = 2;
    cell.subName.layer.masksToBounds = YES;
    //NSLog(@"%@",model.subName);
    
    cell.subName.text = model.subName;
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        HeaderCollectionReusableView *headerView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView" forIndexPath:indexPath];
        headerView.titleLab.text = _subTitle;
        //NSLog(@"测试Header");
        return headerView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"测试sub");
    
    CommonSubModel *model = _subList[indexPath.row];

    [self.deletage pushDetailsViewWithSubId:model.subId andTypeId:_typeId];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
