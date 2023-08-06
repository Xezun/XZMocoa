//
//  Example11ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "Example11ViewController.h"
#import "Example11ViewModel.h"
@import XZMocoa;
@import SDWebImage;

@interface Example11ViewController () <XZMocoaView>

@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation Example11ViewController

+ (void)load {
    [Mocoa(@"https://mocoa.xezun.com/examples/11") setViewNibWithClass:self];
}

- (instancetype)initWithMocoaURL:(NSURL *)url nibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)bundle {
    self = [super initWithMocoaURL:url nibName:nibName bundle:bundle];
    if (self) {
        self.title = @"基本用法二";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wrapperView.layer.cornerRadius = 10.0;
    self.wrapperView.clipsToBounds = YES;

    // 基于控制器的 MVVM 模块，控制器是模块的入口，所以 ViewModel 是由控制器创建的。
    // 1、可以避免影响控制器生命周期，或者控制器生命周期影响 ViewModel 的逻辑处理。
    // 2、控制器作为独立入口，方便与外部引用、交互。
    Example11ViewModel *viewModel = [[Example11ViewModel alloc] init];
    [viewModel ready];
    self.viewModel = viewModel;
    
    [viewModel addTarget:self action:@selector(viewModelDidUpdate:)];
}

- (void)viewModelDidUpdate:(Example11ViewModel *)viewModel {
    self.nameLabel.text = viewModel.name;
    [self.photoImageView sd_setImageWithURL:viewModel.photo];
    self.phoneLabel.text = viewModel.phone;
    self.addressLabel.text = viewModel.address;
    self.titleLabel.text = viewModel.title;
    self.contentLabel.text = viewModel.content;
}

@end
