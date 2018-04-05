//
//  ViewController.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "ViewController.h"

#import "CSInputView.h"
#import "CSTitleView.h"
#import "CSTableView.h"

#import "CSDemoReduxHeader.h"

#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate>

@property (nonatomic,strong) CSInputView *inputView;
@property (nonatomic,strong) CSTitleView *titleView;
@property (nonatomic,strong) CSTableView *tableView;

@property(nonatomic,strong) CSDemoStore *store;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarItem;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"测试";
    
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(80);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).mas_offset(15);
        make.width.mas_equalTo(200);
        (void)make.centerX;
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).mas_offset(15);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-15);
    }];
    
    self.store = [[CSDemoStore alloc] init];
    
    self.titleView.store = self.store;
    self.inputView.store = self.store;
    self.tableView.store = self.store;
    [self.store subscribe:^(CSDemoAction *action, CSDemoState *state) {
        if (action.type == CSDemoActionbeginAddContentType)
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        else if (action.type == CSDemoActionAddContentFinishType)
        {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
        }
    }];
}

- (IBAction)addAction:(id)sender
{
    CSDemoAction *action = [[CSDemoAction alloc] init];
    action.type = CSDemoActionbeginAddContentType;
    [self.store dispatch:action];
}

- (CSInputView *)inputView
{
    if (!_inputView)
    {
        _inputView = [[CSInputView alloc] init];
        _inputView.viewController = self;
    }
    return _inputView;
}

- (CSTitleView *)titleView
{
    if (!_titleView)
    {
        _titleView = [[CSTitleView alloc] init];
        _titleView.viewController = self;
    }
    return _titleView;
}

- (CSTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CSTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.viewController = self;
    }
    return _tableView;
}

@end
