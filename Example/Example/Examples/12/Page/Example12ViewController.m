//
//  Example12ViewController.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example12ViewController.h"
@import XZMocoa;
@import XZExtensions;
@import YYModel;

@interface Example12ViewController ()

@end

@implementation Example12ViewController

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/12/").viewClass = self;
}

- (instancetype)initWithMocoaOptions:(XZMocoaOptions)options nibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)bundle {
    self = [super initWithMocoaOptions:options nibName:nibName bundle:bundle];
    if (self) {
        self.title = @"Example 11";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *data = @[
        @{ @"firstName": @"张", @"lastName": @"三" },
        @{ @"firstName": @"李", @"lastName": @"四" },
        @{ @"firstName": @"王", @"lastName": @"五" }
    ];
    
    XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/examples/12/table/");
    
    // Model
    NSArray *dataArray = [data xz_map:^id _Nonnull(id  _Nonnull obj, NSInteger idx, BOOL * _Nonnull stop) {
        return [module.section.cell.modelClass yy_modelWithDictionary:obj] ?: obj;
    }];
    
    // viewModel
    XZMocoaTableViewModel *tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:dataArray];
    tableViewModel.module = module;
    [tableViewModel ready];
    
    // view
    XZMocoaTableView *tableView = [[XZMocoaTableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    tableView.viewModel = tableViewModel;
    [self.view addSubview:tableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
