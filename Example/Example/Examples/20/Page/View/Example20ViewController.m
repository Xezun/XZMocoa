//
//  Example20ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "Example20ViewController.h"
#import "Example20ViewModel.h"
@import XZRefresh;
@import XZExtensions;

@interface Example20ViewController () <XZMocoaView, XZRefreshDelegate>

@property (weak, nonatomic) IBOutlet XZMocoaTableView *tableView;

@end

@implementation Example20ViewController

@dynamic viewModel;

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20").viewNibClass = self;
}

- (instancetype)initWithMocoaOptions:(XZMocoaOptions)options nibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    self = [super initWithMocoaOptions:options nibName:nibName bundle:bundle];
    if (self) {
        self.title = @"Example 20";
        self.hidesBottomBarWhenPushed = YES;
        self.navigationItem.backButtonTitle = @"返回";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentView.xz_headerRefreshView.delegate = self;
    self.tableView.contentView.xz_footerRefreshView.delegate = self;
    
    Example20ViewModel *viewModel = [[Example20ViewModel alloc] initWithModel:nil ready:YES];
    self.viewModel = viewModel;
    self.tableView.viewModel = viewModel.tableViewModel;
    
    [viewModel addTarget:self action:@selector(headerRefreshingChanged:) forKeyEvents:@"isHeaderRefreshing"];
    [viewModel addTarget:self action:@selector(footerRefreshingChanged:) forKeyEvents:@"isFooterRefreshing"];
}

- (void)headerRefreshingChanged:(Example20ViewModel *)viewModel {
    if (viewModel.isHeaderRefreshing) {
        [self.tableView.contentView.xz_headerRefreshView beginRefreshing];
    } else {
        [self.tableView.contentView.xz_headerRefreshView endRefreshing];
    }
}

- (void)footerRefreshingChanged:(Example20ViewModel *)viewModel {
    if (viewModel.isFooterRefreshing) {
        [self.tableView.contentView.xz_footerRefreshView beginRefreshing];
    } else {
        [self.tableView.contentView.xz_footerRefreshView endRefreshing];
    }
}

- (void)scrollView:(UIScrollView *)scrollView headerDidBeginRefreshing:(XZRefreshView *)refreshView {
    Example20ViewModel *viewModel = self.viewModel;
    [viewModel refreshingHeaderDidBeginAnimating];
}

- (void)scrollView:(UIScrollView *)scrollView footerDidBeginRefreshing:(XZRefreshView *)refreshView {
    Example20ViewModel *viewModel = self.viewModel;
    [viewModel refreshingFooterDidBeginAnimating];
}

@end
