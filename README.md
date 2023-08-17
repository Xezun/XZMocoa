# XZMocoa

[![CI Status](https://img.shields.io/travis/xezun/XZMocoa.svg?style=flat)](https://travis-ci.org/xezun/XZMocoa)
[![Version](https://img.shields.io/cocoapods/v/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)
[![License](https://img.shields.io/cocoapods/l/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)
[![Platform](https://img.shields.io/cocoapods/p/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)

## 示例项目

要运行示例工程，请在拉取代码后，先在`Pods`目录下执行`pod install`命令。

## 版本需求

iOS 11.0+，Xcode 14.0+

## 如何安装

推荐使用 [CocoaPods](https://cocoapods.org) 安装 XZMocoa 框架，在`Podfile`文件中添加下面这行代码即可。

XZMocoa is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'XZMocoa'
```

## 如何使用

Mocoa 是对原生框架的拓展，是为开发者更方便地使用原生框架编写 MVVM 设计模式的代码而设计。

在 MVVM 中，`UIViewController`的角色是`View`，所以 Mocoa 给`UIView`增加了方法，用以获取控制器。

```objc
UIView<XZMocoaView> *view;
[view.navigationController pushViewController:nextVC animated:YES];
```

Mocoa 在设计上尽量使用协议，而不是`Category`或子类，以避免与原生混淆，因为只有在 MVVM 代码中，才需要声明 Mocoa 相关的协议。
比如在上面的代码中，如果使用的是`Category`，那么在 MVC 结构中，也有开发者可能会访问这个方法，这就破坏了 MVC 结构的一致性。



## 模块化



## 解藕

Mocoa 是一款 MVVM 基础框架，因此在 Mocoa 中，原生类可能会有些与传统不同的使用方式，比如`UIView`可以直接打开新的页面，例如。



即在 Mocoa 体系中，`UIViewController`与`UIView`同等对待的，不过大部分情况下 Mocoa 不会像上面这样打开新的页面，例如。

```objc
NSURL *url = [NSURL URLWithString:@"https://xezun.com/main/"];
[view.viewController presentViewControllerWithMocoaURL:url animated:YES completion:nil];
[view.navigationController pushViewControllerWithMocoaURL:url animated:YES];
```

即在 Mocoa 体系中，打开页面只需要页面的`MocoaURL`，而不必知晓页面具体类型。

这么做的好处也显而易见，页面可能会根据业务需要，进行不同的改造升级，但是`URL`却可以保持不变，其它相关页面就不需要额外进行适配。

通过`MocoaURL`可以打开页面，是因为页面已经被定义为 Mocoa 中的模块，所以可以通过模块的地址`MocoaURL`找到并打开它。

除了页面，列表中分块的独立视图，也可以封装为模块。

比如`UITableView`的`cell`视图，定义为模块后，就可以通过`MocoaURL`找到它，那么我们就可以根据后端下发的标识，
通过`MocoaURL`找到对应`cell`，解除了列表`UITableView`对具体`cell`类型的依赖。

### 定义模块

Mocoa 将每一个`Model-View-ViewModel`单元都视为模块。

1、页面模块

大部分情况下，一个独立的页面，就可以成为一个模块，要注册这个模块，最简单的方式是在`+load`方法中。

```objc
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/main/").viewClass = self;
}
```

页面模块，不论是MVC设计模式还是MVVM设计模式，视图控制器都是模块的入口，只不过控制器在两种设计模式中的角色不同，一个是`Controller`，一个是`View`。


### 1、使用 MVVM 设计模式。

Mocoa 建议你使用 MVVM 设计模式进行开发，以充分利用 Mocoa 提供的特性。使用 MVVM 设计模式的目的，可以很好的

提到 MVVM 我们可能会想到响应式编程，但是 Mocoa 不要求开发者必须在 MVVM 模块中使用响应式技术，而仅仅遵循 MVVM 基本要求即可。




## 设计背景

随着业务发展，原生的MVC设计模式，让代码变得越来越难以维护，而现有的MVVM框架，都有着不小的学习、迁移、后期维护成本，因此我们需要一款上手简单、无缝迁移、贴近原生开发模式的MVVM基础框架。

## 基本结构

1. 模块

在Mocoa中，每一个`Model-View-ViewModel`单元都被称为一个`module`模块。模块可以是一个页面，也可以是一个组件。在开发中，我们尽量把逻辑上独立的部分，封装为一个MVVM模块。大部分情况下，一个页面就是一个模块，但是页面很复杂，比如`UITableView`页面，我们又可以将Cell作为一个个子模块，然后建立上下级关系进行交互。

在Mocoa中，`XZMocoaTableView`是对`UITableView`的封装，可以在无感知的情况下，管理Cell子模块，类似的`UICollectionView`也有`XZMocoaCollectionView`可以使用。

2. 解藕

在Mocoa中，使用`URL`机制，对MVVM模块进行解藕。模块`XZMocoaModule`通过URL注册到`XZMocoaDomain`中，任何一个已注册模块都可以通过`URL`在`XZMocoaDomain`中找到。注册机制`XZMocoaDomain`并非针对MVVM模块，任意模块都可以在其中注册，因此需要开发者对`URL`进行管理。

3. 传值

已注册的模块，都可以通过`URL`参数进行传值，特别的对于页面模块，可以通过`UIViewController`的初始化方法传值。

```objc
@interface XZMocoaModule (UIViewControllerInstantiation)
/// 实例化控制器。
/// - Parameter options: 实例化参数，传递给控制器的初始化参数
- (nullable __kindof UIViewController *)instantiateViewControllerWithOptions:(nullable XZMocoaOptions)options;
@end

@interface UIViewController (XZMocoaModuleSupporting)
/// XZMocoa 使用此方法初始化控制器。
/// @discussion
/// 便利初始化方法，默认直接调用 -initWithNibName:bundle: 方法完成初始化。
/// @discussion
/// 子类可以通过重写此方法获取 options 中的参数信息，或将控制器的初始化改为其它初始化方法。
/// @param options 初始化参数
- (instancetype)initWithMocoaOptions:(XZMocoaOptions)options nibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)bundle;
@end
```

## 示例

仓库根目录下的`XZMocoa.xcworkspace`工程，已包含完整的示例程序，拉取代码后，在`Pods`目录下执行`pod install`命令后，即可运行。

## 特性

Mocoa并不要求开发者如何开发MVVM模块，甚至使用MVC模块，也可以与其它Mocoa的MVVM模块无缝连接使用，不过Mocoa还是建议，应遵循最基本的`Model-View-ViewModel`结构。

Mocoa使用协议定义了`Model-View-ViewModel`各个成员，但并不强制要求实现，因此可以很自由的使用现有的代码进行改造。

由于Mocoa已经将一些在MVVM结构中常用的的功能或方便的开发的功能进行了封装，因此建议`ViewModel`使用Mocoa提供的基类`XZMocoaViewModel`类。

### ready机制

Mocoa设计了`ready`机制，来延迟`ViewModel`的初始化，这在某些具有依赖关系的上下级结构中特别有用，比如可以与`UIViewController`的生命周期保持一致。

### 层级关系与层 emit 事件

在模块与子模块之间，建立层级关系，利用层级关系来处理一些基本事件，可以减少编码工作量。

### target-action机制

iOS开发对于“一对一”的键值绑定并不是特别的需要，大部分情况下，在合适的时机统一触发刷新，是最经济和高效的。在iOS中，我们通常使用`delegate`机制来实现此功能。但是`delegate`机制会额外带来不少编写协议的工作量，因此Mocoa设计了`target-action`机制，以提高开发效率，不过Mocoa仍然建议，在确保明了的情况下使用，`delegate`机制不仅仅是效率高，更重要的利于维护。

### XMMocoaTableView/XMMocoaCollectionView

Mocoa为列表页面额外进行了模块化设计，通过`XMMocoaTableView/XMMocoaCollectionView`可以更方便地进行模块化管理列表中的子模块，与`URL`注册结合使用，列表子模块甚至可以做到完全独立。

#### 差异分析与局部更新

在开发中，列表局部刷新虽然不难，但是很麻烦，因为有时可能需要与后端重新设计数据交互方式，因此大部分情况下都是使用`reloadData`方法，但是很明显损失了原生的局部刷新的动态特效，交互体验一般，但是现在，通过Mocoa仅需两步就实现局部刷新。

1. 在`Model`中，确定数据的比较规则。

```objc
- (BOOL)isEqual:(Model *)object {
    return [self.nid isEqualToString:object.nid];
}
```

2. 使用`performBatchUpdates:completion:`刷新列表。

```objc
[_tableViewModel performBatchUpdates:^{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:newData];
} completion:^(BOOL finished) {
    // do something
}];
```

没错，仅需要将更新数据源的操作放在`batchUpdates`块中，就可以实现局部刷新。更多详情，请参考示例代码。

## Author

Xezun, developer@xezun.com

## License

XZMocoa is available under the MIT license. See the LICENSE file for more info.


