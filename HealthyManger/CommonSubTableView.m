//
//  CommonSubTableView.m
//  HealthyManger
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommonSubTableView.h"
#import "CommonModel.h"

@interface CommonSubTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *subArray;
@property (nonatomic,copy)NSString *subListTitle;


@end

@implementation CommonSubTableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        
    {
        _subArray =[NSMutableArray array];
    }
    return self;
}
-(void)createTableViewWithArray:(NSArray *)subList andTitle:(NSString *)subListTitle
{
    UITableView *subTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2.0, self.frame.size.height) style:UITableViewStylePlain];
    subTable.delegate = self;
    subTable.dataSource = self;
    //subTable.backgroundColor =[UIColor redColor];
    subTable.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    subTable.bounces = NO;
    subTable.showsVerticalScrollIndicator = NO;
   // NSLog(@"%ld,%@",subList.count,subList);
    _subArray =[subList mutableCopy];
    _subListTitle = subListTitle;
    [self addSubview:subTable];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subArray.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"subList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    CommonSubModel *model = _subArray[indexPath.row];
    cell.textLabel.text = model.subName;
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.textLabel.textColor =[UIColor orangeColor];
    //NSLog(@"%@",model.subName);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _rowHeight;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _subListTitle;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _rowHeight;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
