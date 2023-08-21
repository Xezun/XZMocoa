//
//  Example10ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "Example10ViewController.h"
// View
#import "Example10RootView.h"
// Model
#import "Example10ContactViewModel.h"
#import "Example10Model.h"


@import YYModel;

@interface Example10ViewController ()
@property (nonatomic, readonly) Example10RootView *rootView;
@end

@implementation Example10ViewController

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/10/").viewClass = self;
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (instancetype)initWithMocoaOptions:(XZMocoaOptions)options nibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)bundle {
    self = [super initWithMocoaOptions:options nibName:nibName bundle:bundle];
    if (self) {
        self.title = @"Example 10";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (Example10RootView *)rootView {
    return (id)self.view;
}

- (void)loadView {
    self.view = [[Example10RootView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 480.0)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemGray6Color;
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0);
    
    [self loadData];
}

- (void)setData:(Example10Model *)data {
    { // config the mvc ui
        self.rootView.contentView.title = data.content.title;
        self.rootView.contentView.content = data.content.content;
    }
    
    { // config the MVVM ui
        Example10ContactViewModel *viewModel = [[Example10ContactViewModel alloc] initWithModel:data.contact ready:YES];
        self.rootView.contactView.viewModel = viewModel;
    }
    
    // layout the ui to fit the data
    [self.rootView setNeedsLayout];
}

- (void)loadData {
    // 从网络或数据库获取数据，这里省略过程。
    NSDictionary *dict = @{
        @"content": @{
            @"title": @"示例说明",
            @"content": @"本示例演示了 MVVM 模块的开发，以及如何在 MVC 结构中使用 MVVM 模块。"
        },
        @"contact": @{
            @"card": @"contact",
            @"firstName": @"Foo",
            @"lastName": @"Bar",
            @"photo": @"https://developer.apple.com/assets/elements/icons/xcode/xcode-64x64_2x.png",
            @"phone": @"13923459876",
            @"address": @"北京市海淀区人民路幸福里小区7号楼6单元503室"
        }
    };
    
    // 解析数据
    Example10Model *data = [Example10Model yy_modelWithDictionary:dict];
    
    // 更新视图
    [self setData:data];
}

@end
