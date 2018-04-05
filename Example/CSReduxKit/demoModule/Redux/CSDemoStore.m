//
//  CSDemoStore.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSDemoStore.h"
#import "CSDemoReducer.h"
#import "CSDemoState.h"

@implementation CSDemoStore

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.state = [[CSDemoState alloc] init];
    }
    return self;
}

- (void)dispatch:(CSDemoAction *)action
{
    CSDemoReducer *reducer = [CSDemoReducer new];
    [reducer executeWithAction:action state:self.state finishBlock:^(CSDemoState *state) {
        
        self.state = state;
        [self executeAllSubscribeWithAction:action state:state];

    }];
}

@end
