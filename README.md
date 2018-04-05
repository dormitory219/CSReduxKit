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

....


## Author

dormitory219, 289067005@qq.com

## License

CSReduxKit is available under the MIT license. See the LICENSE file for more info.
