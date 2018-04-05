//
//  CSTitleView.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSTitleView.h"
#import <Masonry/Masonry.h>
#import "CSDemoReduxHeader.h"

@interface CSTitleView()

@property (nonatomic,strong) UIButton *button;

@end

@implementation CSTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:button];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            (void)make.top.bottom.centerX;
        }];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"标题" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        _button = button;
    }
    return self;
}

- (void)setStore:(CSDemoStore *)store
{
    _store = store;
    [store subscribe:^(CSDemoAction *action,CSDemoState *state) {
        if (action.type == CSDemoActionbeginAddContentType)
        {
            [self.button setTitle:@"正在添加文本中...." forState:UIControlStateNormal];
        }
        else if (action.type == CSDemoActionAddContentFinishType)
        {
            [self.button setTitle:state.currentAddText forState:UIControlStateNormal];
        }
        else if (action.type == CSDemoActionDeleteContent)
        {
            [self.button setTitle:state.currentAddText forState:UIControlStateNormal];
        }
        else if (action.type == CSDemoActionCellClick)
        {
            [self.button setTitle:state.currentAddText forState:UIControlStateNormal];
        }
    }];
}

- (void)clickTitleAction:(UIButton *)button
{
    CSDemoAction *action = [[CSDemoAction alloc] init];
    action.type = CSDemoActionTitleClick;
    action.data = button.titleLabel.text;
    [self.store dispatch:action];
}

@end
