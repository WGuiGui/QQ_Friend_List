//
//  ViewController.m
//  QQ好友列表收展
//
//  Created by 王飞飞 on 14-11-26.
//  Copyright (c) 2014年 WFF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *openArray;
    NSMutableArray * sectitleArr;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    sectitleArr = [NSMutableArray arrayWithObjects:@"好友",@"同学",@"陌生人",@"黑名单", nil];
    openArray=[[NSMutableArray alloc]init];
    NSNumber *num=[NSNumber numberWithBool:YES];
    
    [openArray addObject:num];
    [openArray addObject:num];
    [openArray addObject:num];
    [openArray addObject:num];//此处得num／openArray和分组的数量有关
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[openArray objectAtIndex:section] boolValue]==NO) {
        
        return 0;
    } else {
        
        return 10;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectitleArr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectitleArr[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text=sectitleArr[indexPath.section];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor lightGrayColor];

    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(0, 0, 100,40);
    button.tag=section;
    button.backgroundColor = [UIColor redColor];
    [button setTitle:sectitleArr[section] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    return view;
}

-(void)buttonClick:(UIButton *)button
{
    BOOL isOpen=[[openArray objectAtIndex:button.tag]boolValue];
    if (isOpen==YES) {
        NSNumber *num= [NSNumber numberWithBool:NO];
        [openArray replaceObjectAtIndex:button.tag withObject:num];
    } else {
        NSNumber *num=[NSNumber numberWithBool:YES];
        [openArray replaceObjectAtIndex:button.tag withObject:num];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end



















