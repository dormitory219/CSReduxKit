//
//  CSDemoState.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSDemoState.h"

@implementation CSDemoState

- (void)updateWithData:(id)data
{
    if (!data)
    {
        NSLog(@"data is nil,just return");
        return;
    }
    if ([data isMemberOfClass:[NSString class]])
    {
        NSLog(@"data not string,just return");
        return;
    }
    self.currentAddText = data;
    self.canEdit = NO;
    [self.listDataArray addObject:data];
}

- (void)removeWithData:(id)data
{
    if (![data isKindOfClass:[NSNumber class]])
    {
        NSLog(@"data not number,just return");
        return;
    }
    
    NSNumber *number = (NSNumber *)data;
    [self.listDataArray removeObjectAtIndex:number.integerValue];
    self.currentAddText = self.listDataArray.lastObject;
}

- (NSMutableArray <NSString *>*)listDataArray
{
    if (!_listDataArray)
    {
        _listDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _listDataArray;
}

@end
