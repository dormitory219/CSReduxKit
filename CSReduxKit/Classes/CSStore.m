//
//  CSStore.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSStore.h"

@interface CSStore()

@property (nonatomic,strong) NSMutableArray *subscriptions;

@end


@implementation CSStore

@synthesize state;

- (void)dispatch:(CSAction *)action
{
    CSReducer *reducer = [CSReducer new];
    [reducer executeWithAction:action state:self.state finishBlock:^(CSState *state) {
        
        self.state = state;
        
        [self executeAllSubscribeWithAction:action state:state];
    }];
}

- (void)executeAllSubscribeWithAction:(CSAction *)action state:(CSState *)state
{
    for (Subscription subscription in self.subscriptions)
    {
        subscription(action,state);
    }
}

- (void)subscribe:(Subscription)subscription
{
    if ([self.subscriptions containsObject:subscription])
    {
        NSLog(@"subscription has subscribe,just reture");
        return;
    }
    [self.subscriptions addObject:subscription];
}

- (void)unSubscribe:(Subscription)subscription
{
    if ([self.subscriptions containsObject:subscription])
    {
        NSLog(@"subscription not subscribe,just reture");
        return;
    }
    [self.subscriptions removeObject:subscription];
}

- (NSMutableArray *)subscriptions
{
    if (!_subscriptions)
    {
        _subscriptions = [NSMutableArray arrayWithCapacity:1];
    }
    return _subscriptions;
}

@end
