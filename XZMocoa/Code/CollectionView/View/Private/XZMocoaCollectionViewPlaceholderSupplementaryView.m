//
//  XZMocoaCollectionViewPlaceholderSupplementaryView.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaCollectionViewPlaceholderSupplementaryView.h"
#import "XZMocoaTableViewPlaceholderCell.h"
#import "XZMocoaCollectionViewSectionViewModel.h"

#if DEBUG
@implementation XZMocoaCollectionViewPlaceholderSupplementaryView {
    NSString *_reason;
    NSString *_detail;
    UILabel *_textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0xf8 / 255.0 green:0x5d / 255.0 blue:0x75 / 255.0 alpha:1.0];
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.textColor = UIColor.whiteColor;
        [self addSubview:_textLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.frame = UIEdgeInsetsInsetRect(self.bounds, self.layoutMargins);
}

- (void)viewModelDidChange {
    XZMocoaCollectionViewSupplementaryViewModel * const viewModel = self.viewModel;
    XZMocoaCollectionViewSectionViewModel * const superViewModel = viewModel.superViewModel;
    
    XZMocoaName const section = ((id<XZMocoaModel>)superViewModel.model).mocoaName ?: XZMocoaNameNone;
    XZMocoaName const cell    = ((id<XZMocoaModel>)viewModel.model).mocoaName ?: XZMocoaNameNone;
    
    _reason = [XZMocoaTableViewPlaceholderCell reasonByCheckingModule:viewModel.module];
    [superViewModel.supplementaryViewModels enumerateKeysAndObjectsUsingBlock:^(XZMocoaKind kind, NSArray<XZMocoaViewModel *> *obj, BOOL * _Nonnull stop) {
        if ([obj containsObject:viewModel]) {
            _detail = [NSString stringWithFormat:@"section: %@, %@: %@", section, kind, cell];
            *stop = YES;
        }
    }];
    
    _textLabel.text = [NSString stringWithFormat:@"%@ %@", _reason, _detail];
}

- (void)tapAction:(id)sender {
    [XZMocoaTableViewPlaceholderCell showAlertForView:self model:self.viewModel.model reason:_reason detail:_detail];
}

@end
#endif
