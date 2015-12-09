//
//  porvinceCellView.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "porvinceCellView.h"

#import "FactoryProvinceModel.h"

@interface porvinceCellView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *modelArray;

@property (nonatomic,strong)NSNumber *ID;
@end

@implementation porvinceCellView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _modelArray =[NSMutableArray array];
    }
    return self;
}

-(void)createTableViewWithArray:(NSMutableArray *)array
{
    UITableView *table =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    table.delegate = self;
    table.dataSource = self;
    table.bounces = NO;
    
    _modelArray = array;
    //NSLog(@"cell----%@",_modelArray);
    [table reloadData];
    [self addSubview:table];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"myCell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    FactoryProvinceModel *model = _modelArray[indexPath.row];
    cell.textLabel.text = model.province;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FactoryProvinceModel *model = _modelArray[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _ID = model.ID;
    _slectPorvice(cell.textLabel.text,_ID);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
