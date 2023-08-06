# Mocoa

[![CI Status](https://img.shields.io/travis/sweetyxia/Mocoa.svg?style=flat)](https://travis-ci.org/sweetyxia/Mocoa)
[![Version](https://img.shields.io/cocoapods/v/Mocoa.svg?style=flat)](https://cocoapods.org/pods/Mocoa)
[![License](https://img.shields.io/cocoapods/l/Mocoa.svg?style=flat)](https://cocoapods.org/pods/Mocoa)
[![Platform](https://img.shields.io/cocoapods/p/Mocoa.svg?style=flat)](https://cocoapods.org/pods/Mocoa)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Mocoa is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Mocoa'
```

## Author

sweetyxia, developer@xezun.com

## License

Mocoa is available under the MIT license. See the LICENSE file for more info.


两个控制器需要传值：
将二级页面作为一级页面的子模块，由一级页面的 View 打开二级页面，一级页面的 ViewModel 提供二级页面的 ViewModel，二级页面的 ViewModel 与一级页面就可以通过层级链传值。

控制器之间不需要传值，直接打开 URL 即可。


# Mocoa

就现在来说 MVVM 已经不属于新鲜事物，但是在 iOS 开发中，它并不是很常见。这主要是由于 Objective-C 的语言特性，在使用 MVVM 设计模式时，不能像 JavaScript 一样，在框架层就可以直接处理数据监听或事件绑定逻辑。一般 Objectiv-C 需要额外的书写很多代码来处理这些逻辑，而且 Cocoa MVC 深入人心，在组织代码和规范上，也会面临很多问题。而像 ReacNative 这样的 MVVM 框架，但是太过于系统，学习成本高，上手难且也有组织代码、规范和维护成本的问题。
鉴于此 Mocoa 框架在设计时，在遵循 MVVM 设计模式的基础上，尽量地保留了传统的开发模式，以降低上手入门成本。

## 一、MVVM

### 1、定义

<img src="../../../images/module.png" height="212">

### 2、实现

下面的是 MVVM 设计模式标准示例，它是最简单的一个示例，但是不论如何设计，在 MVVM 设计模式下，都源自这种结构。

```objc
@interface Model : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phone;
@end
@implementation Model
@end

@interface ViewModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
- (instancetype)initWithModel:(Model *)model;
@end
@implementation ViewModel
- (instancetype)initWithModel:(Model *)model {
    self = [super init];
    if (self) {
        _name = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
        _phone = model.phone;
    }
    return self;
}
@end

@interface View : UIView
@property (nonatomic, strong, nullable) VellModel *viewModel;
- (instancetype)initWithViewModel:(ViewModel *)viewModel;
@end
@implementation View
- (instancetype)initWithViewModel:(ViewModel *)viewModel {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        self.nameLabel.text = viewModel.name;
        self.phoneLabel.text = viewModel.phone;
    }
    return self;
}
@end
```

上面的代码，虽然没有数据监听与事件绑定的逻辑，但是请记住这种最基本的范式，MVVM 框架千千万，任何一种框架都是基于这种基本结构而来。而对于这种简单结构，实际上是不需要什么框架的，所以框架的真正作用并不是解决 MVVM 设计模式的问题，而是为了解决数据监听和事件绑定的问题，比如要监听 `Model.phone` 的变化，在 react 中就像下面这么处理。

```objc
[RACObserve(model, phone) subscribeNext:^(NSString *newValue) {
    NSLog(@"%@", newValue);
}];
```

虽然基于 react 实现 MVVM 相对容易，但是 react 框架更侧重于响应式编程的实现，基于信号机制的事件传递，上手难度较大且不易规范和管理，而且相对来说，这个框架太重，不符合现状需求。

> 关于链式编程和响应式编程
> 一般情况下，链式编程一般也指的是响应式编程，因为如果仅仅是代码书写格的改变，很明显是不能够单独称为一种编程方式。而且通常情况，常规的编程模式下，可以通过点语法形成链的场景并不很多，而响应式编程思想，在逻辑上就很容易形成“链”。比如处理按钮点击事件，通常情况下，我们要先创建视图，然后绑定事件，然后在另一个地方处理事件，但响应式编程，则是在创建按钮的时候，就直接编写按钮事件的代码，即创建视图、处理事件等一些列流程可以直接通过“链”链接起来。

### 3、解藕

在实际应用中，为了提高复用性，解决 ViewModel 对 Model 的依赖，以及 View 对 ViewModel 的依赖，定义 Model 与 ViewModel 时一般协议，而非具体的类型。比如对于 ViewModel 一般像下面这样设计，以解除对 Model 的耦合并提供复用的可能。

```objc
@protocol Model <NSObject>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phone;
@end

@interface ViewModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
- (instancetype)initWithModel:(Model *)model;
@end
@implementation ViewModel
- (instancetype)initWithModel:(id<Model>)model {
    self = [super init];
    if (self) {
        _name = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
        _phone = model.phone;
    }
    return self;
}
@end
```

同理，设计 View 时，也不需要具体的 ViewModel 的类型，只要定好协议，负责处理该逻辑的 ViewModel 在接入时，实现这个协议即可。

```objc
@protocol ViewModel <NSObject>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@end

@interface View : UIView
- (instancetype)initWithViewModel:(id<ViewModel>)viewModel;
@end
@implementation View
- (instancetype)initWithViewModel:(id<ViewModel>)viewModel {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        self.nameLabel.text = viewModel.name;
        self.phoneLabel.text = viewModel.phone;
    }
    return self;
}
```

上门的两个示例中，依然没有数据监听和事件绑定的处理逻辑。而在实际 iOS 开发中，要进行数据监听和事件绑定场景占比并不是很大，标准的 MVVM 模型基本能涵盖大部分场景，所以使用 Cocoa 的方式处理数据和事件，进行 MVVM 开发并非不可能。

## Mocoa

Mocoa 是一套非常轻量级的 MVVM 框架，框架自身对 Cocoa 没有任何侵入性，它们可以无缝的结合使用。而且 Mocoa 也没有对 MVVM 的实现方式也没有强制的限定，实际开发中，你可以使用任何形式的 MVVM 进行开发。另外，Mocoa 也提供了一些基础方法，用于处理数据和事件，但是你可以完全不使用这套规则。

#### MocoaView 协议

任何 UIView 遵循 MocoaView 协议，即可成为一个具有 Mocoa 基本属性的视图。

- 1、获得 viewModel 属性。
- 2、接收 viewModel 的 willChange/didChange 事件。
- 3、直接获取所属控制器进行转场及 IB 转场支持。 

#### MocoaGroupedView/MocoaStyledView 协议

对于 UITableView/UICollectionView 这样的列表视图，如果将整体作为独立单元处理，必然导致 ViewModel 过于臃肿，因此 Mocoa 提供了基于 Group/Style 的注册机制，将列表分化为基于 Cell 的独立单元处理。

#### MocoaModel
// Mocoa 是 MVVM Cocoa 的缩写，它是一款轻量级的 MVVM 框架。
//
// 【命名规范】
// 1、数据模型以`DataModel`结尾。
// 2、视图模型以`ViewModel`结尾。
// 3、视图命名与通用规则一致，比如以`View/Bar/Cell/Button`结尾。
// 4、控制器在MVVM中属于视图，虽然不再处理业务逻辑，但是依然是根视图的角色，继续使用`Controller`命名。
// 5、为避免命名冲突，以`mocoa`作为类目属性和方法的前缀。
//
// 【逻辑、视图分层】
// 为了将业务逻辑分块处理，在使用 Mocoa 框架开发时，开发者应该对复杂页面进行合理的分层：
// 1、一般而言，视图模型的层级关系，与视图的层级关系是一一对应的。
// 2、上级层拥有并管理它的所有下级层，但是不参与下级任何具体的逻辑。
// 比如：table 层应只处理 section 视图模型，而 section 处理 header/cell/footer 视图模型。
// 视图的上下级关系与视图模型的上下级关系并非一一对应，比如 tableView 与它的下拉刷新视图是上下级关系，
// 但是下来刷新却是直接与控制器交互的，把它作为控制器视图模型的下级，处理起来会更方便。


# Mocoa

就现在来说 MVVM 已经不属于新鲜事物，但是在 iOS 开发中，它并不是很常见。这主要是由于 Objective-C 的语言特性，在使用 MVVM 设计模式时，不能像 JavaScript 一样，在框架层就可以直接处理数据监听或事件绑定逻辑。一般 Objectiv-C 需要额外的书写很多代码来处理这些逻辑，而且 Cocoa MVC 深入人心，在组织代码和规范上，也会面临很多问题。而像 ReacNative 这样的 MVVM 框架，但是太过于系统，学习成本高，上手难且也有组织代码、规范和维护成本的问题。
鉴于此 Mocoa 框架在设计时，在遵循 MVVM 设计模式的基础上，尽量地保留了传统的开发模式，以降低上手入门成本。

## 一、MVVM

### 1、定义

<img src="../../../images/module.png" height="212">

### 2、实现

下面的是 MVVM 设计模式标准示例，它是最简单的一个示例，但是不论如何设计，在 MVVM 设计模式下，都源自这种结构。

```objc
@interface Model : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phone;
@end
@implementation Model
@end

@interface ViewModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
- (instancetype)initWithModel:(Model *)model;
@end
@implementation ViewModel
- (instancetype)initWithModel:(Model *)model {
    self = [super init];
    if (self) {
        _name = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
        _phone = model.phone;
    }
    return self;
}
@end

@interface View : UIView
@property (nonatomic, strong, nullable) VellModel *viewModel;
- (instancetype)initWithViewModel:(ViewModel *)viewModel;
@end
@implementation View
- (instancetype)initWithViewModel:(ViewModel *)viewModel {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        self.nameLabel.text = viewModel.name;
        self.phoneLabel.text = viewModel.phone;
    }
    return self;
}
@end
```

上面的代码，虽然没有数据监听与事件绑定的逻辑，但是请记住这种最基本的范式，MVVM 框架千千万，任何一种框架都是基于这种基本结构而来。而对于这种简单结构，实际上是不需要什么框架的，所以框架的真正作用并不是解决 MVVM 设计模式的问题，而是为了解决数据监听和事件绑定的问题，比如要监听 `Model.phone` 的变化，在 react 中就像下面这么处理。

```objc
[RACObserve(model, phone) subscribeNext:^(NSString *newValue) {
    NSLog(@"%@", newValue);
}];
```

虽然基于 react 实现 MVVM 相对容易，但是 react 框架更侧重于响应式编程的实现，基于信号机制的事件传递，上手难度较大且不易规范和管理，而且相对来说，这个框架太重，不符合现状需求。

> 关于链式编程和响应式编程
> 一般情况下，链式编程一般也指的是响应式编程，因为如果仅仅是代码书写格的改变，很明显是不能够单独称为一种编程方式。而且通常情况，常规的编程模式下，可以通过点语法形成链的场景并不很多，而响应式编程思想，在逻辑上就很容易形成“链”。比如处理按钮点击事件，通常情况下，我们要先创建视图，然后绑定事件，然后在另一个地方处理事件，但响应式编程，则是在创建按钮的时候，就直接编写按钮事件的代码，即创建视图、处理事件等一些列流程可以直接通过“链”链接起来。

### 3、解藕

在实际应用中，为了提高复用性，解决 ViewModel 对 Model 的依赖，以及 View 对 ViewModel 的依赖，定义 Model 与 ViewModel 时一般协议，而非具体的类型。比如对于 ViewModel 一般像下面这样设计，以解除对 Model 的耦合并提供复用的可能。

```objc
@protocol Model <NSObject>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phone;
@end

@interface ViewModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
- (instancetype)initWithModel:(Model *)model;
@end
@implementation ViewModel
- (instancetype)initWithModel:(id<Model>)model {
    self = [super init];
    if (self) {
        _name = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
        _phone = model.phone;
    }
    return self;
}
@end
```

同理，设计 View 时，也不需要具体的 ViewModel 的类型，只要定好协议，负责处理该逻辑的 ViewModel 在接入时，实现这个协议即可。

```objc
@protocol ViewModel <NSObject>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@end

@interface View : UIView
- (instancetype)initWithViewModel:(id<ViewModel>)viewModel;
@end
@implementation View
- (instancetype)initWithViewModel:(id<ViewModel>)viewModel {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        self.nameLabel.text = viewModel.name;
        self.phoneLabel.text = viewModel.phone;
    }
    return self;
}
```

上门的两个示例中，依然没有数据监听和事件绑定的处理逻辑。而在实际 iOS 开发中，要进行数据监听和事件绑定场景占比并不是很大，标准的 MVVM 模型基本能涵盖大部分场景，所以使用 Cocoa 的方式处理数据和事件，进行 MVVM 开发并非不可能。

## Mocoa

Mocoa 是一套非常轻量级的 MVVM 框架，框架自身对 Cocoa 没有任何侵入性，它们可以无缝的结合使用。而且 Mocoa 也没有对 MVVM 的实现方式也没有强制的限定，实际开发中，你可以使用任何形式的 MVVM 进行开发。另外，Mocoa 也提供了一些基础方法，用于处理数据和事件，但是你可以完全不使用这套规则。

#### XZMocoaView 协议

任何 UIView 遵循 XZMocoaView 协议，即可成为一个具有 Mocoa 基本属性的视图。

- 1、获得 viewModel 属性。
- 2、接收 viewModel 的 willChange/didChange 事件。
- 3、直接获取所属控制器进行转场及 IB 转场支持。 

#### XZMocoaGroupedView/XZMocoaStyledView 协议

对于 UITableView/UICollectionView 这样的列表视图，如果将整体作为独立单元处理，必然导致 ViewModel 过于臃肿，因此 Mocoa 提供了基于 Group/Style 的注册机制，将列表分化为基于 Cell 的独立单元处理。

#### XZMocoaModel
