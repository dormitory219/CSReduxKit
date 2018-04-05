//
//  CSDemoReducer.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSDemoReducer.h"

@implementation CSDemoReducer

- (void)executeWithAction:(CSDemoAction *)action state:(CSDemoState *)state finishBlock:(void (^)(id<CSStateProtocol>))finishBlock
{
    switch (action.type)
    {
        case CSDemoActionbeginAddContentType:
        {
            state.canEdit = YES;
        }
            break;
        case CSDemoActionAddContentFinishType:
        {
            if (action.data)
            {
                [state updateWithData:action.data];
            }
        }
            break;
        case CSDemoActionDeleteContent:
        {
            if (action.data)
            {
                [state removeWithData:action.data];
            }
        }
            break;
            
        case CSDemoActionTitleClick:
        {
            if (action.data)
            {
                state.title = (NSString *)action.data;
            }
        }
            break;
            
        case CSDemoActionCellClick:
        {
            if (action.data)
            {
                state.currentAddText = (NSString *)action.data;
            }
        }
            break;
            
        default:
            break;
    }
    finishBlock ? finishBlock(state) : nil;
}

@end
