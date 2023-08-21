
# XZMocoa

[![CI Status](https://img.shields.io/travis/xezun/XZMocoa.svg?style=flat)](https://travis-ci.org/xezun/XZMocoa)
[![Version](https://img.shields.io/cocoapods/v/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)
[![License](https://img.shields.io/cocoapods/l/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)
[![Platform](https://img.shields.io/cocoapods/p/XZMocoa.svg?style=flat)](https://cocoapods.org/pods/XZMocoa)

## 示例项目

要运行示例工程，请在拉取代码后，先在`Pods`目录下执行`pod install`命令。

To run the example project, clone the repo, and run `pod install` from the Pods directory first.

## 版本需求

iOS 11.0+，Xcode 14.0+

## 如何安装

推荐使用 [CocoaPods](https://cocoapods.org) 安装 XZMocoa 框架，在`Podfile`文件中添加下面这行代码即可。

XZMocoa is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'XZMocoa'
```

## 如何使用

`UITableView`是 iOS 开发中的常用组件，下面以编写`UITableView`列表为例，介绍如何使用 Mocoa 进行开发。

由于`UITableView`在设计上，并不是十分的符合在 MVVM 设计模式下使用，因此 Mocoa 将其简单地封装为`XZMocoaTableView`。
封装只是简单地将其放在`UIView`中，没有其它处理，在本质上与`UITableView`没有区别。

1、设计数据

将数据设计成符合`UITableView`两层数据结构的形式，肯定会大大的简化数据处理的过程。
Mocoa 为`UITableView`的数据设计了两个标准协议`XZMocoaTableModel`和`XZMocoaTableViewSectionModel`，以增加数据的通用性。

```objc
@protocol XZMocoaTableModel <XZMocoaModel>
@property (nonatomic, readonly) NSInteger numberOfSectionModels;
- (nullable id<XZMocoaTableSectionModel>)modelForSectionAtIndex:(NSInteger)index;
@end

@protocol XZMocoaTableSectionModel <XZMocoaModel>
@optional
@property (nonatomic, readonly) NSInteger numberOfCellModels;
- (nullable id)modelForCellAtIndex:(NSInteger)index;

- (NSInteger)numberOfModelsForSupplementaryKind:(XZMocoaKind)kind;
- (nullable id)modelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index;
@end
```

严格来讲，数据不应该承担业务逻辑，但是很明显，这两个协议只是为了统一获取`UITableView`列表数据的接口，可以算也可以不算是业务逻辑，
而将数据的标准，由数据自身处理，维护起来也更方便。

另外，Mocoa 会自动使用数组`NSArray`的中元素，而非数组本身；如果是二维数组，一维元素作为`section`数据，二维元素作为`cell`数据。

2、创建列表

```objc
// model
NSArray *dataArray;
// viewModel
XZMocoaTableViewModel *tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:dataArray];
tableViewModel.module = XZMocoa(@"https://mocoa.xezun.com/table/");
[tableViewModel ready];
// view
XZMocoaTableView *tableView = [[XZMocoaTableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
tableView.viewModel = tableViewModel;
[self.view addSubview:tableView];
```

在创建`cell`前，你就可以渲染列表了，在 DEBUG 环境下，Mocoa 会使用“占位视图”渲染目标`cell`，这样你就可以提前验证数据格式是否设计的正确了。

3、开发`cell`模块

使用 Mocoa 你可以将每一个`cell`都看作是完全独立的模块进行开发，然后注册到想要展示的`tableView`模块中即可使用。

开发`cell`模块，与开发普通 MVVM 模块的过程基本一样，仅需要按照 MVVM 的基本要求编写即可。

3.1 定义 View、ViewModel、Model

```objc
@interface ExampleCell : UITableViewCell <XZMocoaTableViewCell>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@interface ExampleCellViewModel : XZMocoaTableViewCellViewModel
@property (nonatomic, copy) NSString *name;
@end

@interface ExampleCellModel : NSObject <XZMocoaTableViewCellModel>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@end
```

除了`ViewModel`需要使用 Mocoa 提供的基类外，`View`和`Model`是完全自由的，协议`XZMocoaTableViewCell`和`XZMocoaTableViewCellModel`都提供了默认实现，可以直接使用。

3.2 处理数据

`ViewModel`将数据处理为`View`展示所需的类型。

```objc
@implementation ExampleCellViewModel
- (void)prepare {
    [super prepare];

    self.height = 44.0;
    
    ExampleModel *data = self.model;
    self.name = [NSString stringWithFormat:@"%@ %@", data.firstName, data.lastName];
}

- (void)tableView:(XZMocoaTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 处理 cell 的点击事件
}
@end
```

3.3 渲染视图

`View`根据`ViewModel`提供的数据进行展示。

```objc
@implementation ExampleCell
- (void)viewModelDidChange {
    ExampleViewModel *viewModel = self.viewModel;
    
    self.nameLabel.text = viewModel.name;
}
@end
```

方法`viewModelDidChange`是 Mocoa 提供的方法，一般在这里装载视图内容。

3.4 注册模块

虽然`section`是逻辑层，在`UITableView`中虽然没有直接视图，但是 Mocoa 保留了它，因此`cell`是注册在`section`之下的。

```objc
@implementation ExampleCellModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/table/").section.cell.modelClass = self;
}
@end

@implementation ExampleCell
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/table/").section.cell.viewNibClass = self;
}
@end

@implementation ExampleCellViewModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/table/").section.cell.viewModelClass = self;
}
@end
```

在这个示例中，我们只有一种类型的`section`和`cell`，不需要具名，所以直接使用`.section.cell`注册。
当`cell`模块注册后，我们在运行代码，我们就可以看到列表已经渲染成功了。

至此，使用`XZMocoaTableView`渲染列表的一个简单示例就完成了，与使用原生的`UITableView`相比：

- 不用编写`delegate`或`dataSource`方法。
- 不用先编写`cell`，Mocoa 会先用占位视图替代，直到`cell`模块编写完成。
- `cell`模块完全独立，编写`cell`后，仅需注册模块，不需在`tableView`或`collectionView`中注册。

还有，再也不用一遍遍地触发原生的`Crash`来调试`UITableView`了。

## 模块化

不论采用何种设计模式，都应该让你的代码模块化。这样在更新维护时，变动就可以控制在模块内，从而避免牵一发而动全身。

Mocoa 使用 MVVM 设计模式进行模块化，因为在 MVVM 设计模式下，视图可以通过自身的`ViewModel`管理逻辑，可以避免控制器变得越来越重。

Mocoa 为模块提供了基于 URL 的模块管理方案 `XZMocoaDomain`，任何模块都可以通过`URL`在`XZMocoaDomain`中注册。

```objc
[[XZMocoaDomain doaminForName:@"mocoa.xezun.com"] setModule:yourModule forPath:@"your/module/path"];
```

上面例子中的模块地址为`https://mocoa.xezun.com/your/module/path/`，其中 URL 的`scheme`是任意的。

```objc
id yourModule = [[XZMocoaDomain doaminForName:@"mocoa.xezun.com"] moduleForPath:@"your/module/path"];
```

`XZMocoaDomain`其实就是简单地使用`NSMutableDictionary`进行管理模块，所以你不必担心它的性能问题。

在实际开发中，有些提供了各种各样方法的“模块”，通过上面注册的方式拿到一个匿名的`id`类型，似乎显得多次一举。
但是在 Mocoa 看来，这样的“模块”并不是真正的模块，而只是一个组件或提供方法的工具类，因为真正的模块应该是能独自完成功能的，不需要或者仅需要少量简单明了的参数。
比如每个 App 实际上就是一个独立的模块，`main(int, char *)`是它们统一入口函数。

Mocoa 将每一个 MVVM 单元`Model-View-ViewModel`都视为一个 Mocoa 模块，即`XZMocoaModule`模块，并做如下约定。

- `Model`使用`-init`作为初始化方法，或者开发者自行约定统一的方法。
- `ViewModel`使用`-initWithModel:`作为初始化方法。
- `View`中的`UIViewController`使用`-initWithNibName:bundle:`作为初始化方法
- `View`中的`UIView`一般使用`-initWithFrame:`作为初始化方法，像`UITableViewCell`等被管理的视图，则它们自身决定。

然后，我们就可以在 Mocoa 中注册 MVVM 模块的`View`、`Model`、`ViewModel`三个部分了。

```objc
XZMocoa(@"https://mocoa.xezun.com/").modelClass = Model.class;
XZMocoa(@"https://mocoa.xezun.com/").viewClass = View.class;
XZMocoa(@"https://mocoa.xezun.com/").viewModelClass = ViewModel.class;
```

*注：函数`XZMocoa(url)`是`+[XZMocoaModule moduleForURL:]`的便利写法。*

MVVM 模块在注册后，我们就可以按照约定好的基本规则使用它们了，比如对于一个普通的视图模块，我们在拿到数据后，可以像下面这样使用它。

```objc
NSDictionary *data;
XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/");

id<XZMocoaModel>      model     = [module.modelClass yy_modelWithDictionary:data]; // 这里使用了 YYModel 组件
XZMocoaViewModel    * viewModel = [[module.viewModelClass alloc] initWithModel:model];
UIView<XZMocoaView> * view      = [[module.viewClass alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];

[self.view addSubview:view];
```

对于页面`UIViewController`模块，Mocoa 认为它是一个独立模块，所以在启动页面时，提供了便利方法。

```objc
UIView<XZMocoaView> *view;
NSURL *url = [NSURL URLWithString:@"https://mocoa.xezun.com/main"];
[view.navigationController pushViewControllerWithMocoaURL:url animated:YES];
```

即通过 URL 直接打开目的页面。使用`View`打开控制器，在 MVC 设计模式中是不合理的，但是在 MVVM 设计模式，`UIViewController`仅仅是特殊的`View`而已。

最后，注册模块的时机，要在所有业务逻辑开始之前，因此`+load`方法是最合适的。

```objc
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20/content/").viewNibClass = self;
}
```

但是如果项目组对`+load`方法使用有限制，可以通过`XZMocoaDomainModuleProvider`协议自定义`XZMocoaDomain`的模块提供方式，比如读配置文件。

```objc
@protocol XZMocoaDomainModuleProvider <NSObject>
- (nullable id)domain:(XZMocoaDomain *)domain moduleForName:(NSString *)name atPath:(NSString *)path;
@end
```

在层级关系中，子模块的路径，一般就是它的名字，比如：

- `https://mocoa.xezun.com/table/`: `table`模块
- `https://mocoa.xezun.com/table/name1/`: `name1`是`table`模块的子模块
- `https://mocoa.xezun.com/table/name1/name2/`: `name2`是`name1`模块的子模块，`name1`是`table`模块的子模块

如果子模块有分类，使用`:`分隔，比如：

- `https://mocoa.xezun.com/table/header:name1/`: `name1`是`table`模块的`header`子模块
- `https://mocoa.xezun.com/table/footer:name2/`: `name2`是`table`模块的`footer`子模块

模块也可以没有名字和分类，但是在路径中，没有分类可以省略`:`，没有名字不能省略`:`，比如：

- `https://mocoa.xezun.com/table/name/`:        合法
- `https://mocoa.xezun.com/table/kind:name/`:   合法
- `https://mocoa.xezun.com/table/kind:/`:       合法
- `https://mocoa.xezun.com/table/:/`:           合法
- `https://mocoa.xezun.com/table/kind/`:        不合法

## Mocoa MVVM

Mocoa 建议使用 MVVM 模式设计您的代码，包括控制器，而且列表页面中，每一个区块视图`cell`也应该设计为独立的 MVVM 模块。

Mocoa 为更好的在页面中使用 MVVM 设计模式，拓展了一些原生能力。

- `XZMocoaView`协议，Model 遵循此协议，以表明 Model 是 MVVM 中的 `Model` 元素。
- `XZMocoaModel`协议，View 遵循此协议，以表明 View 是 MVVM 中的 `View` 元素。
- `XZMocoaViewModel`基类，`ViewModel`提供的功能要复杂的多，无法通过协议的方式呈现，因此提供了基类。

Mocoa 与其说是框架，不如说是规范，通过协议规范 MVVM 的实现方法。

### 层级机制

在页面模块中，子视图模块，与父视图模块或控制器模块，存在明显的上下级关系。充分利用这种层级关系，可以更方便的处理页面中的一些上下级的交互逻辑，因此 Mocoa 设计了`ViewModel`的层级关系。

```objc
[superViewModel addSubViewModel:viewModel];
[viewModel insertSubViewModel:viewModel atIndex:1]
```

然后我们就可以通过层级关系，收发`emit`事件。

```objc
// send the emition
- (void)emit:(NSString *)name value:(id)value;

// handle the emition
- (void)subViewModel:(XZMocoaViewModel *)subViewModel didEmit:(XZMocoaEmition *)emition;
```

比如在`UITableView`列表中，`cell`模块改变了内容时，希望`UITableView`模块刷新页面时，可以像下面这样处理。

```objc
// 在 cell 中
- (void)handleUserAction {
    // change the data then
    self.height = 100; // a new height
    [self emit:XZMocoaEmitUpdate value:nil];
}

// 在 UITableView 模块中
- (void)subViewModel:(__kindof XZMocoaViewModel *)subViewModel didEmit:(XZMocoaEmition *)emition {
    if ([emition.name isEqualToString:XZMocoaEmitUpdate]) {
        [self reloadData];
    }
}
```

当前这么做，需要一些默认的约定，比如将`XZMocoaEmitUpdate`作为刷新视图的事件。
在 MVC 中，解决上面的问题，一般是通过`delegate`实现，这明显或破坏模块的整体性，上层模块与下层模块的`delegate`形成了耦合，但是利用层级关系处理，就能很好的避免这一点。

同时，层级关系事件的局限性也很明显，仅适合处理比较明确的事件，不过在模块封装完整的情况下，下层模块也不应该有其它事件需要传递给上级处理。

### ready 机制

在模块层级关系中，模块在创建时，可能并不需要立即初始化，或者模块需要额外的初始化参数，比如在`UIViewController`中，应该在`viewDidLoad`时初始化，因此 Mocoa 设计了`ready`机制来延迟`ViewModel`的初始化时机。

在`ready`机制下，开发者应该在`ViewModel`的`-prepare`方法中进行初始化。

```objc

- (void)prepare {
    [super prepare];

    // 执行当前模块的初始化
}

```

如果是顶层模块，应该在合适的时机调用`ViewModel`的`-ready`方法。比如页面模块，一般是顶层模块，建议在`-viewDidLoad`中执行。

```objc
- (void)viewDidLoad {
    [super viewDidLoad];

    Example20ViewModel *viewModel = [[Example20ViewModel alloc] initWithModel:nil];
    [viewModel ready];

    self.viewModel = viewModel;
    self.tableView.viewModel = viewModel.tableViewModel;
}
```

因为控制器顶层模块，引用模块时不需要准备数据，它的数据是`ViewModel`自行处理的，所以初始化它的`model`是`nil`，在`View`中自己创建`ViewModel`也是合理的。
同时 Mocoa 也约定：

- 在顶层独立的`UIViewController`页面模块中，应由`View`（即`UIViewController`）在合适的时机自行创建`ViewModel`。

由外部提供数据的不完全独立的页面模块，加载使用方式则与`UIView`基本一致。

```objc
XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/");

id model;
XZMocoaViewModel *viewModel = [[module.viewModelClass alloc] initWithModel:model];
UIViewController<XZMocoaView> *nextVC = [module instantiateViewControllerWithOptions:nil];
nextVC.viewModel = viewModel; // not ready here, and nextVC must call -ready in -viewDidLoad method before use it.
[view.navigationController pushViewController:nextVC animated:YES];
```

Mocoa 为独立的顶层模块，提供了进入的便利方法。

```objc
// UIViewController
- (void)presentViewControllerWithMocoaURL:(nullable NSURL *)url animated:(BOOL)flag completion:(void (^_Nullable)(void))completion;
- (void)addChildViewControllerWithMocoaURL:(nullable NSURL *)url;
// UINavigationController
- (void)pushViewControllerWithMocoaURL:(nullable NSURL *)url animated:(BOOL)animated;
```

### target-action

在 MVVM 设计模式中，`View`通过监听`ViewModel`的属性来展示页面，但是实际上，大部分情况下，`View`并不需要一直监听，因为大多数的`View`只需要渲染一次。
所以 Mocoa 没有设计如何实现监听的代码，因为大部分页面渲染在`viewModelDidChange`中就能完成了。

在剩下的小部分情况中，我们可以通过`delegate`的方式来实现，这比监听更直观，且易维护。
不过，使用`delegate`由于需要定义协议，使用起来比较麻烦，所以了简化这些在少量事件的处理，Mocoa 设计了`target-action`机制。

这是一种半自动的机制，使用`NSString`作为`keyEvents`，`View`在绑定的`keyEvents`之后，`ViewModel`在调用`-sendActionsForKeyEvents:`方法时，`View`绑定的方法就会被触发。

```objc
// view 监听了 viewModel 的 isHeaderRefreshing 属性
[viewModel addTarget:self action:@selector(headerRefreshingChanged:) forKeyEvents:@"isHeaderRefreshing"];

- (void)headerRefreshingChanged:(Example20ViewModel *)viewModel {
    if (viewModel.isHeaderRefreshing) {
        [self.tableView.contentView.xz_headerRefreshingView beginAnimating];
    } else {
        [self.tableView.contentView.xz_headerRefreshingView endAnimating];
    }
}

// viewModel 发送事件
[self sendActionsForKeyEvents:@"isHeaderRefreshing"];
```

`target-action`机制，相当于使用`keysEvents`代替了`delegate`协议，处理一些简单的事件。

### MVVM 化适配

原生的大部分视图控件，在 MVVM 设计模式下使用，都是合适的，但某些特殊类型的视图，需要进行 MVVM 化之后，才适合在 MVVM 中使用。
比如具有视图管理功能的`UITableView`和`UICollectionView`列表视图，Mocoa 将它们封装为更适合在 MVVM 设计模式中使用的`XZMocoaTableView`和`XZMocoaCollectionView`视图。

#### UIView 的适配化

在 MVVM 中，`UIViewController`的角色是`View`，所以在 Mocoa 中，通过`View`可以直接获取对应的控制器。


```objc
@protocol XZMocoaView <NSObject>
@property (nonatomic, readonly, nullable) __kindof UIViewController *viewController;
@property (nonatomic, readonly, nullable) __kindof UINavigationController *navigationController;
@property (nonatomic, readonly, nullable) __kindof UITabBarController *tabBarController;
@end
```

#### UITableView/UICollectionView 的适配化

`XZMocoaTableView`和`XZMocoaCollectionView`是适配化后的列表视图，仅对`UITableView`和`UICollectionView`进行了一次简单的封装。

1. 通过`ViewModel`管理`cell`的高度。

```objc
@interface XZMocoaTableCellViewModel : XZMocoaListityCellViewModel
@optional
@property (nonatomic) CGFloat height;
@end
```

2. 列表事件，重新转发给`cell`，并再转发给`ViewModel`处理。

```objc
@interface XZMocoaTableCellViewModel : XZMocoaListityCellViewModel
@optional
- (void)tableView:(XZMocoaTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(XZMocoaTableView *)tableView willDisplayRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(XZMocoaTableView *)tableView didEndDisplayingRowAtIndexPath:(NSIndexPath*)indexPath;
@end
```

Mocoa 目前默认只转发了基本的三个事件，如需要更多事件，需要开发者重写或在`Category`中自行实现。

3. 同步更新视图。

当数据变化后，调用`ViewModel`相应的方法，即可更新视图。

```objc
[_dataArray removeObjectAtIndex:0];
[_tableViewModel deleteSectionAtIndex:0];
``` 

4. 批量更新及自动差异分析。

在传统的列表展示页面中，由于数据是通过服务端请求的，我们很少分析数据进行局部更新，而是在获取到数据后，直接`reloadData`刷新页面。

现在通过 Mocoa 的自动差异分析功能，直接实现局部更新。

```objc
[_tableViewModel performBatchUpdates:^{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:newData];
} completion:^(BOOL finished) {
    // do something
}];
```

将更新数据的操作，放在`batchUpdates`块中，即会自动进行差异分析，并进行局部刷新。

Mocoa 的差异分析功能依赖数据的`-isEqual:`方法，因此需要在`Model`中重写此方法。
当然，如果在数据层已经做了数据管理，比如从数据层获取的数据，同一数据始终是同一个对象，或已经做了`-isEqual:`处理，这一步就可以省略。

```objc
- (BOOL)isEqual:(Example20Group102CellModel *)object {
    if (object == self) return YES;
    if (![object isKindOfClass:[Example20Group102CellModel class]]) return NO;
    return [self.nid isEqualToString:object.nid];
}
```

自动差异分析从而，局部刷新的效果，在“示例工程”中有完整的展示以供参考。

## Author

Xezun, developer@xezun.com

## License

XZMocoa is available under the MIT license. See the LICENSE file for more info.


