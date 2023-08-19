
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

### 1、编写 MVVM 模块

Mocoa 对如何实现模块没有具体要求，按照 MVVM 的基本要求编写即可。

1.1 定义 View、ViewModel、Model

`View`就是产品最终呈现的样子，不论是纯代码，还是 xib/storyboard 都可以。

```objc
@interface ExampleView : UIView <XZMocoaView>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
```

`ViewModel`对`View`提供直接用于展示的数据。

```objc
@interface ExampleViewModel : XZMocoaViewModel
@property (nonatomic, copy) NSString *name;
@end
```

`Model`是包含展示元素的数据，一般需要经过`ViewModel`的处理。

```objc
@interface ExampleModel : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@end
```

1.2 处理数据

`ViewModel`将数据处理为`View`展示所需的类型。

```objc
@implementation ExampleViewModel
- (void)prepare {
    [super prepare];
    
    ExampleModel *data = self.model;
    self.name = [NSString stringWithFormat:@"%@ %@", data.firstName, data.lastName];
}
@end
```

1.3 渲染视图

`View`根据`ViewModel`提供的数据进行展示。

```objc
@implementation ExampleView
- (void)viewModelDidChange {
    ExampleViewModel *viewModel = self.viewModel;
    
    self.nameLabel.text = viewModel.name;
}
@end
```

### 2、注册 MVVM 模块

```objc
@implementation ExampleModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/example/").modelClass = self;
}
@end

@implementation ExampleView
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/example/").viewNibClass = self;
}
@end

@implementation ExampleView
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/example/").viewModelClass = self;
}
@end
```

### 3、使用 MVVM 模块

```objc
NSDictionary *data;
XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/example/");
// Model
id<XZMocoaModel> model = [module.modelClass yy_modelWithDictionary:data];
// ViewModel
XZMocoaViewModel *viewModel = [[module.viewModelClass alloc] initWithModel:model];
[viewModel ready];
// View
UIView<XZMocoaView> *view = [module instantiateViewWithFrame:CGRectMake(0, 0, 100, 100)];
view.viewModel = viewModel;
// show the view
[self.view addSubview:view];
```

### 4、具名的模块

一般情况下，一个页面模块，可能包含多个不同类型的视图模块，为了区分这些视图模块，我们应该为它们分别取一个名字。
然后将这些视图模块，注册为页面模块的子模块。

```objc
XZMocoa(@"https://mocoa.xezun.com/page/view1/").modelClass     = view1ModelClass;
XZMocoa(@"https://mocoa.xezun.com/page/view1/").viewClass      = view1ViewClass;
XZMocoa(@"https://mocoa.xezun.com/page/view1/").viewModelClass = view1ViewModelClass;
```

页面的数据如果是下发的，我们需要分析数据的不同，然后找到对应视图模块，最后加载模块。
一般情况，我们不用去分析整个数据，而是在数据中设置一个`identifier`标识符，用来表明数据对应的视图类型，且为了方便维护，我们一般会将模块的名字与标识符保持相同。
在 Mocoa 中，这样的标识符，有一个通用的名字——`mocoaName`。

```objc
@implementation ExampleModel
- (NSString *)mocoaName {
    return self.identifier; 
}
@end
```

在页面获取到数据后，我们就可以根据数据`mocoaName`读取子模块，然后渲染页面。

```objc
XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/example/");

CGFloat y = 0;
for (id<XZMocoaModel> data in _dataArray) {
    XZMocoaModule *submodule = [module submoduleForName:data.mocoaName];

    id model = [submodule.modelClass yy_modelWithDictionary:data];
    id viewModel = [[submodule.viewModelClass alloc] initWithModel:model ready:YES];
    UIView<XZMocoaView> * view = [submodule instantiateViewWithFrame:CGRectMake(0, y, 100, 50)];
    view.viewModel = viewModel;
    [self.view addSubview:view];

    y += 60;
}
```

当然，如果页面由固定模块组成，那么直接使用视图模块`URL`也是可以的，因为`mocoaName`的目的也是获得子模块。

### 5、渲染列表

使用`XZMocoaTableView`或`XZMocoaCollectionView`渲染列表。

```objc
// model
NSArray<XZMocoaTableModel> *dataArray;
// viewModel
XZMocoaTableViewModel *tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:dataArray];
tableViewModel.module = XZMocoa(@"https://mocoa.xezun.com/list/");
[tableViewModel ready];
// view
XZMocoaTableView *tableView = [[XZMocoaTableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
tableView.viewModel = tableViewModel;
[self.view addSubview:tableView];
```

与`UITableView`或`UICollectionView`相比，使用`XZMocoaTableView`或`XZMocoaCollectionView`不用注册`cell`也不用编写`delegate`或`dataSource`方法。
当然能这么做的前提是，各个`cell`模块已经注册成为`XZMocoaTableView`或`XZMocoaCollectionView`的子模块。

由于在`tableView`中，有`section`逻辑层，`cell`并不是`tableView`的直接子模块，而是`section`的直接子模块，所以注册如下。

```objc
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/list/{sectionName}/{cellName}/").viewModelClass = self;
}
```

在多`section`多`cell`的情况下，你需要为不同类型的`section`和`cell`取一个`mocoaName`进行区分。
编写`cell`模块的编写，与编写普通的`UIView`模块相同，只是如何使用`cell`模块，已经由`XZMocoaTableView`在内部实现了，我们需要做的就是实现`cell`模块的功能，并注册它。

所以在 Mocoa 框架下，每个`cell`都是独立的 MVVM 模块，添加到任何`tableView`的子模块中，都可以直接使用。

另外，作为`XZMocoaTableView`的数据，需要遵循以下两个协议。

```objc
@protocol XZMocoaListityModel <XZMocoaModel>
@property (nonatomic, readonly) NSInteger numberOfSectionModels;
- (nullable id<XZMocoaListityViewSectionModel>)modelForSectionAtIndex:(NSInteger)index;
@end

@protocol XZMocoaListityViewSectionModel <XZMocoaModel>
@optional
@property (nonatomic, readonly) NSInteger numberOfCellModels;
- (nullable id)modelForCellAtIndex:(NSInteger)index;

@property (nonatomic, readonly) NSArray<XZMocoaKind> *supplementaryKinds;
- (NSInteger)numberOfModelsForSupplementaryKind:(XZMocoaKind)kind;
- (nullable id)modelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index;
@end
```

*`ListityView`是`TableView`和`CollectionView`在逻辑上的抽象。*

这两个协议只是为了方便`tableView`和`colletionView`任何获取对应视图数据，`NSArray`是天然的`XZMocoaTableView`的数据，可以直接使用。
严格来讲，应该由`ViewModel`实现，数据模型不应实现任何方法。
但很明显，这些方法可以算，也可以不算是业务逻辑，由数据模型实现更方便维护。


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
@interface XZMocoaTableViewCellViewModel : XZMocoaListityViewCellViewModel
@optional
@property (nonatomic) CGFloat height;
@end
```

2. 列表事件，重新转发给`cell`，并再转发给`ViewModel`处理。

```objc
@interface XZMocoaTableViewCellViewModel : XZMocoaListityViewCellViewModel
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


