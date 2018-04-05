//
//  CSReduxHeader.h
//  CSReduxKit
//
//  Created by 余强 on 2018/4/5.
//  Copyright © 2018年 余强. All rights reserved.
//

#ifndef CSReduxHeader_h
#define CSReduxHeader_h

@protocol CSActionProtocol,CSStateProtocol,CSReducerProtocol;

typedef void(^Subscription)(id <CSActionProtocol> action,id<CSStateProtocol>state);

@protocol CSStoreProtocol<NSObject>

@property (nonatomic,strong) id<CSStateProtocol> state;

- (void)dispatch:(id<CSActionProtocol>)action;

- (void)subscribe:(Subscription)subscription;

- (void)unSubscribe:(Subscription)subscription;

- (void)executeAllSubscribeWithAction:(id<CSActionProtocol>)action state:(id<CSStateProtocol>)state;

@end

@protocol CSReducerProtocol<NSObject>

- (void)executeWithAction:(id<CSActionProtocol>)action state:(id<CSStateProtocol>)state finishBlock:(void (^)(id <CSStateProtocol> state))finishBlock;

@end

@protocol CSActionProtocol<NSObject>

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) id data;

@end

@protocol CSStateProtocol<NSObject>

@end


#endif /* CSReduxHeader_h */
