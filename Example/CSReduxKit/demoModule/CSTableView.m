//
//  CSTableView.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSTableView.h"
#import "CSDemoReduxHeader.h"

@interface CSTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation CSTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return self;
}

- (void)setStore:(CSDemoStore *)store
{
    _store = store;
    [store subscribe:^(CSDemoAction *action,CSDemoState *state) {
        CSDemoAction *demoAction = (CSDemoAction *)action;
        CSDemoState *demoState = (CSDemoState *)state;
        if (demoAction.type == CSDemoActionTitleClick)
        {
            for (NSString *data in self.dataArray)
            {
                if ([data isEqualToString:demoState.title])
                {
                    NSInteger index = [self.dataArray indexOfObject:data];
                    NSIndexPath *indePath = [NSIndexPath indexPathForRow:index inSection:0];
                    [self selectRowAtIndexPath:indePath animated:YES scrollPosition:UITableViewScrollPositionTop];
                }
            }
        }
        else if (demoAction.type == CSDemoActionCellClick)
        {
            //do nothing
        }
        else
        {
            self.dataArray = demoState.listDataArray;
            [self reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.backgroundColor = [UIColor colorWithRed:0.1*arc4random_uniform(10) green:0.1*arc4random_uniform(10) blue:0.1*arc4random_uniform(10) alpha:1];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    CSDemoAction *demoAction = [[CSDemoAction alloc] init];
    demoAction.type = CSDemoActionCellClick;
    demoAction.data = self.dataArray[indexPath.row];
    [self.store dispatch:demoAction];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CSDemoAction *demoAction = [[CSDemoAction alloc] init];
        demoAction.type = CSDemoActionDeleteContent;
        demoAction.data = [NSNumber numberWithInteger:indexPath.row];
        [self.store dispatch:demoAction];
    }
}

@end
