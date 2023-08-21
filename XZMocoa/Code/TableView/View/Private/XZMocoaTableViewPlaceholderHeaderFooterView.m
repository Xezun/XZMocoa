//
//  XZMocoaTableViewPlaceholderHeaderFooterView.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaTableViewPlaceholderHeaderFooterView.h"
#import "XZMocoaTableViewPlaceholderCell.h"
#import "XZMocoaTableViewSectionViewModel.h"

#if DEBUG
@implementation XZMocoaTableViewPlaceholderHeaderFooterView {
    NSString *_reason;
    NSString *_detail;
    UILabel *_textLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0xf8 / 255.0 green:0x5d / 255.0 blue:0x75 / 255.0 alpha:1.0];
        self.backgroundView = backgroundView;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.font  = [UIFont systemFontOfSize:14.0];
        _textLabel.textColor = UIColor.whiteColor;
        [self.contentView addSubview:_textLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.frame = UIEdgeInsetsInsetRect(self.bounds, self.layoutMargins);
}

- (void)viewModelDidChange {
    XZMocoaTableViewHeaderFooterViewModel * const viewModel      = self.viewModel;
    XZMocoaTableViewSectionViewModel      * const superViewModel = viewModel.superViewModel;
    
    XZMocoaName const section = ((id<XZMocoaModel>)superViewModel.model).mocoaName ?: XZMocoaNameNone;
    XZMocoaName const cell    = ((id<XZMocoaModel>)viewModel.model).mocoaName ?: XZMocoaNameNone;
    
    _reason = [XZMocoaTableViewPlaceholderCell reasonByCheckingModule:viewModel.module];
    
    if (superViewModel.headerViewModel == viewModel) {
        _detail = [NSString stringWithFormat:@"section: %@, header: %@", section, cell];
    } else {
        _detail = [NSString stringWithFormat:@"section: %@, footer: %@", section, cell];
    }
    
    _textLabel.text = [NSString stringWithFormat:@"模块%@ %@", _reason, _detail];
}

- (void)tapAction:(id)sender {
    [XZMocoaTableViewPlaceholderCell showAlertForView:self model:self.viewModel.model reason:_reason detail:_detail];
}

@end
#endif
