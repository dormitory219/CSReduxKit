//
//  CSDemoAction.h
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSAction.h"

typedef enum : NSUInteger
{
    CSDemoActionbeginAddContentType,//开始进入编辑状态
    
    CSDemoActionAddContentFinishType, //文字添加结束
    
    CSDemoActionDeleteContent, //删除一条文本记录
    
    CSDemoActionTitleClick, //点击title
    
    CSDemoActionCellClick //点击cell
    
} CSDemoActionType;

@interface CSDemoAction : CSAction

@end
