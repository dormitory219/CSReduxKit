//
//  CSDemoState.h
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSState.h"

@interface CSDemoState : CSState

@property (nonatomic,strong) NSMutableArray <NSString *> *listDataArray;

//正编辑新添加的文本记录
@property (nonatomic,copy) NSString *currentAddText;

//是否可编辑状态
@property (nonatomic,assign) BOOL canEdit;

//正在显示的标题内容
@property (nonatomic,copy) NSString *title;

- (void)updateWithData:(id)data;

- (void)removeWithData:(id)data;

@end
