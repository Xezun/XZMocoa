//
//  XZMocoaTableViewPlaceholderHeaderFooterView.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaTableViewPlaceholderHeaderFooterView.h"

#if DEBUG
@implementation XZMocoaTableViewPlaceholderHeaderFooterView {
    UILabel *_textLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.font  = [UIFont systemFontOfSize:14.0];
        _textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.frame = UIEdgeInsetsInsetRect(self.bounds, self.layoutMargins);
}

- (void)viewModelDidChange {
    XZMocoaTableViewHeaderFooterViewModel * const viewModel = self.viewModel;
    XZMocoaTableViewSectionViewModel * const superViewModel = viewModel.superViewModel;
    
    XZMocoaName const section = ((id<XZMocoaModel>)superViewModel.model).mocoaName ?: XZMocoaNameNone;
    XZMocoaName const cell    = ((id<XZMocoaModel>)viewModel.model).mocoaName ?: XZMocoaNameNone;
    
    NSString *reason = nil;
    if (viewModel.module == nil) {
        reason = @"模块未注册";
    } else if (viewModel.module.viewClass == Nil) {
        reason = @"模块缺少 View 组件";
    } else {
        reason = @"模块缺少 ViewModel 组件";
    }
    
    if (superViewModel.headerViewModel == viewModel) {
        _textLabel.text = [NSString stringWithFormat:@"%@ section: %@, header: %@", reason, section, cell];
    } else {
        _textLabel.text = [NSString stringWithFormat:@"%@ section: %@, footer: %@", reason, section, cell];
    }
}

@end
#endif
