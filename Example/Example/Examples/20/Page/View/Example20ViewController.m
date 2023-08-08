//
//  Example20ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "Example20ViewController.h"
#import "Example20ViewModel.h"

@interface Example20ViewController () <XZMocoaView>

@property (weak, nonatomic) IBOutlet XZMocoaTableView *tableView;

@end

@implementation Example20ViewController

@dynamic viewModel;

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20").viewNibClass = self;
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
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [refresh addTarget:self action:@selector(refreshControlAction:) forControlEvents:(UIControlEventValueChanged)];
    self.tableView.contentView.refreshControl = refresh;
    
    Example20ViewModel *viewModel = [[Example20ViewModel alloc] initWithModel:nil ready:YES];
    self.viewModel = viewModel;
    self.tableView.viewModel = viewModel.tableViewModel;
    
    [viewModel addTarget:self action:@selector(headerRefreshingChanged:) forKeyEvents:@"isHeaderRefreshing"];
    [viewModel addTarget:self action:@selector(footerRefreshingChanged:) forKeyEvents:@"isFooterRefreshing"];
}

- (void)refreshControlAction:(UIRefreshControl *)sender {
    Example20ViewModel *viewModel = self.viewModel;
    [viewModel headerDidBeginRefreshing];
}

- (void)headerRefreshingChanged:(Example20ViewModel *)viewModel {
    if (viewModel.isHeaderRefreshing) {
        [self.tableView.contentView.refreshControl beginRefreshing];
    } else {
        [self.tableView.contentView.refreshControl endRefreshing];
    }
}

- (void)footerRefreshingChanged:(Example20ViewModel *)viewModel {
    if (viewModel.isFooterRefreshing) {
        [self.tableView.contentView.refreshControl beginRefreshing];
    } else {
        [self.tableView.contentView.refreshControl endRefreshing];
    }
}

@end
