//
//  CSTitleView.h
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSDemoStore.h"

@interface CSTitleView : UIView

@property (nonatomic,weak) UIViewController *viewController;
@property (nonatomic,strong) CSDemoStore *store;

@end
