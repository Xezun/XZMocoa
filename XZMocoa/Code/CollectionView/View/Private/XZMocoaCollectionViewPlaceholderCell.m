//
//  XZMocoaCollectionViewPlaceholderCell.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaCollectionViewPlaceholderCell.h"
#import "XZMocoaTableViewPlaceholderCell.h"

#if DEBUG
@implementation XZMocoaCollectionViewPlaceholderCell {
    NSString *_reason;
    NSString *_detail;
    UILabel *_textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = UIColor.brownColor;
        self.backgroundView = backgroundView;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textLabel.textColor = UIColor.whiteColor;
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)viewModelDidChange {
    XZMocoaCollectionViewCellViewModel * const viewModel = self.viewModel;
    XZMocoaCollectionViewSectionViewModel * const superViewModel = viewModel.superViewModel;
    
    XZMocoaName const section = ((id<XZMocoaModel>)superViewModel.model).mocoaName ?: XZMocoaNameNone;
    XZMocoaName const cell    = ((id<XZMocoaModel>)viewModel.model).mocoaName ?: XZMocoaNameNone;
    
    _reason = [XZMocoaTableViewPlaceholderCell reasonByCheckingModule:viewModel.module];
    _detail = [NSString stringWithFormat:@"section: %@, cell: %@", section, cell];
    
    _textLabel.text = [NSString stringWithFormat:@"%@ %@", _reason, _detail];
}

@end
#endif
