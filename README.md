# XZMocoa

[![CI Status](https://img.shields.io/travis/sweetyxia/XZMocoa.svg?style=flat)](https://travis-ci.org/sweetyxia/XZMocoa)
[![Version](https://img.shields.io/cocoapods/v/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)
[![License](https://img.shields.io/cocoapods/l/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)
[![Platform](https://img.shields.io/cocoapods/p/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XZMocoa is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XZMocoa'
```

## 背景

MVVM设计模式已经不是新鲜事物，但是在iOS开发中，却不是很常见。原因一，大概时是因为Apple为开发者提供了一套基本完善的MVC架构开发体系。原因二，则可能是由于Objective-C的语言特性，基于MVVM设计模式的开发框架，与其它平台相比，相差太多，而且大部分对于原生开发者，有一定的入门成本。
随着代码量的日益增长，原生框架已难以满足开发需求，不管是从维护成本，还是开发效率，都面临巨大考验。而目前流行的MVVM框架，虽然能满足要求，但是切换成本、学习成本、维护成本，并不是很理想，鉴于此，设计一款上手简单且贴近原生开发模式的MVVM框架，已变的非常必要。因此，在遵循MVVM设计模式和原生开发方式的基础上，Mocoa框架应运而生。

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


