//
//  CSTableView.h
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSDemoStore.h"

@interface CSTableView : UITableView

@property (nonatomic,strong) CSDemoStore *store;
@property (nonatomic,weak) UIViewController *viewController;
@end
