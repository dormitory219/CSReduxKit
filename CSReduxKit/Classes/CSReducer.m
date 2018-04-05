//
//  CSReducer.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSReducer.h"

@implementation CSReducer

- (void)executeWithAction:(CSAction *)action state:(CSState *)state finishBlock:(void (^)(id<CSStateProtocol>))finishBlock
{
    switch (action.type)
    {
        case 0:
            break;
            
        default:
            break;
    }
    finishBlock ? finishBlock(state) : nil;
}

@end
