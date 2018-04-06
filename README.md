# CSReduxKit

[![CI Status](http://img.shields.io/travis/dormitory219/CSReduxKit.svg?style=flat)](https://travis-ci.org/dormitory219/CSReduxKit)
[![Version](https://img.shields.io/cocoapods/v/CSReduxKit.svg?style=flat)](http://cocoapods.org/pods/CSReduxKit)
[![License](https://img.shields.io/cocoapods/l/CSReduxKit.svg?style=flat)](http://cocoapods.org/pods/CSReduxKit)
[![Platform](https://img.shields.io/cocoapods/p/CSReduxKit.svg?style=flat)](http://cocoapods.org/pods/CSReduxKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CSReduxKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CSReduxKit'
```

## Knowledge

CSReduxkit是基于redux在iOS上实现的一个单向数据流方案。

相关概念：
[Redux 中文文档](http://www.redux.org.cn)

iOS大佬onevcat曾对redux做过相关介绍。

可参考文章：
[单向数据流动的函数式 View Controller](https://onevcat.com/2017/07/state-based-viewcontroller/)

### redux概念

![Alt text](./redux_basic_data_flow.gif)

当用户点击了视图上的某个元素时，会发出一个 Action，
这个 Action 包含了两个基本元素：

- Action Type;
- Action data;

比如「点击按钮」这个 Action，可能会被描述为：Action(“buttonClickAction”, [“ID”: 100])。然后这个 Action 就会到达 Store。
Store 也很简单，只做两件事：

- 接收 Action；
- 将 Action 和 State 发送给 Reducer。

Reducer 做的事情就更简单了，接收 Store 发出的 Action 和 State，内部运算之后，返回一个新的 State。
Store 拿到了新的 State 后，再把 State 发送给 View。View 渲染新的 State。

各模块职责：
1. View

View 可以理解为一个「壳」，所有的数据都由 State 提供，这样就把表现层和数据层分开了。

2. Action

Action 用来描述发生了什么事情，比如不小心用脚踢到了椅子，神经系统就会把这个信息传递给大脑，这个信息就是 Action，而大脑就是之后要讲到的 Store。

3. Store

store是核心模块，就像大脑会不停地接受到各种 Action，并作出反应，只不过在这里 Store 并不具备「做决定」的能力，而是把这个 Action 交给了所有可能关心它的 Reducer。

4. State

State 是一个隐形的杀手，因为使用它极其方便，而它的危害也不会瞬间爆发，就像温水煮青蛙一样，等发现问题越来越多、被各种多线程问题困扰时，就会感受到它的威力了。

5. Reducer 

reducer负责接收 Store 发出的 Action 和 State，内部运算之后，返回一个新的 State 给 store。

### CSReduxKit实现

##### Store
与Redux类似，在使用CSReduxKit的模块，数据收于store这一层，修改也是在这一层，我们不提倡一个app只有一个store，而是根据不同的模块划分不同的store,该store继承于CSStore,CSStore遵循CSStoreProtocol协议：

```
@protocol CSStoreProtocol<NSObject>

@property (nonatomic,strong) id<CSStateProtocol> state;

- (void)dispatch:(id<CSActionProtocol>)action;

- (void)subscribe:(Subscription)subscription;

- (void)unSubscribe:(Subscription)subscription;

- (void)executeAllSubscribeWithAction:(id<CSActionProtocol>)action state:(id<CSStateProtocol>)state;

@end
```

##### Reducer
CSReducer负责对store传入的action,state将数据重新打包成新的状态返回到store, CSAction遵循CSReducerProtocol协议：

```
@protocol CSReducerProtocol<NSObject>

- (void)executeWithAction:(id<CSActionProtocol>)action state:(id<CSStateProtocol>)state finishBlock:(void (^)(id <CSStateProtocol> state))finishBlock;

@end
```

##### Action
CSAction定义为视图对象的更新操作，比如点击一个按钮，开始输入文字，刷新tableView等。CSAction遵循CSActionProtocol协议：

```
@protocol CSActionProtocol<NSObject>

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) id data;

@end
```

### Example
Example是一个通过C SReduxKit 实现的一个单向数据流界面。


交互为点击右上角添加按钮，进入文本输入状态，文本输入后添加一条记录到下方的 tableView 中实时显示，同时上面的 title 视图也会更新显示最新一条添加记录。

该界面视图元素有：

- 上方的标题视图(CSTitleView)
- 中间的文本输入视图(CSInputView)
- 下方的tableView(CSTableView)

这三个视图元素都单独功能封装了，这样的一个交互就可以体现一个视图的事件触发如何通知更新到界面中其他所有需要更新的元素去刷新内容。

**例如点击右上角“添加”这个动作，CSReduxKit是怎样做的：**

*生成 CSDemoAction ，dispatch action 到 CSDemoStore：*

```
//ViewController.m

- (IBAction)addAction:(id)sender
{
    CSDemoAction *action = [[CSDemoAction alloc] init];
    action.type = CSDemoActionbeginAddContentType;
    [self.store dispatch:action];
}
```

*CSDemoStore 将 action，state 交给 CSDemoReducer 处理：*

```
//CSDemoStore.m

- (void)dispatch:(CSDemoAction *)action
{
    CSDemoReducer *reducer = [CSDemoReducer new];
    [reducer executeWithAction:action state:self.state finishBlock:^(CSDemoState *state) {
        
        self.state = state;
        [self executeAllSubscribeWithAction:action state:state];

    }];
}
```

*CSDemoReducer 根据 action 更新 state ,返回到 store：*

```
//CSDemoReducer.m

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
            
        default:
            break;
    }
    finishBlock ? finishBlock(state) : nil;
}
```

*之后 store 再通知所有订阅的视图模块去更新内容：*

```
//CSDemoStore.m

    [reducer executeWithAction:action state:self.state finishBlock:^(CSDemoState *state) {
        
        self.state = state;
        [self executeAllSubscribeWithAction:action state:state];

    }];
```

*这时 CSInputView 收到通知，根据 action，state 做自己应该做的事情：*

```
//CSInputView.m

- (void)setStore:(CSDemoStore *)store
{
    _store = store;
    [store subscribe:^(CSDemoAction *action,CSDemoState *state) {
        CSDemoAction *demoAction = (CSDemoAction *)action;
        if (demoAction.type == CSDemoActionbeginAddContentType)
        {
            [self.textField becomeFirstResponder];
        }
        else if (demoAction.type == CSDemoActionAddContentFinishType)
        {
            [self.textField resignFirstResponder];
            self.textField.text = nil;
        }
    }];
}

```

*CSTableView 也是如此：*

```
//CSTableView.m

- (void)setStore:(CSDemoStore *)store
{
    _store = store;
    [store subscribe:^(CSDemoAction *action,CSDemoState *state) {
        CSDemoAction *demoAction = (CSDemoAction *)action;
        CSDemoState *demoState = (CSDemoState *)state;
        if (demoAction.type == CSDemoActionTitleClick)
        {
            //doSth
        }
    }];
}

```

view action -> store -> reducer -> store -> view 渲染的流程就走完。



## Author

dormitory219, 289067005@qq.com

## License

CSReduxKit is available under the MIT license. See the LICENSE file for more info.
