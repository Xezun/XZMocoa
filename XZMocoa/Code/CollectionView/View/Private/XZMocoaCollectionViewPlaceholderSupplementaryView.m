//
//  XZMocoaCollectionViewPlaceholderSupplementaryView.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaCollectionViewPlaceholderSupplementaryView.h"
#import "XZMocoaTableViewPlaceholderCell.h"

#if DEBUG
@implementation XZMocoaCollectionViewPlaceholderSupplementaryView {
    NSString *_reason;
    NSString *_detail;
    UILabel *_textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.purpleColor;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textLabel.textColor = UIColor.whiteColor;
        [self addSubview:_textLabel];
    }
    return self;
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

@end
#endif
