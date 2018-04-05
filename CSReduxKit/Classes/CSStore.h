//
//  CSStore.h
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSState.h"
#import "CSAction.h"
#import "CSReducer.h"
#import "CSReduxProtocol.h"

@interface CSStore : NSObject<CSStoreProtocol>

@end
