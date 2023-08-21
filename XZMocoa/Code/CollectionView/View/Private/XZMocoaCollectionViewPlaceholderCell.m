//
//  XZMocoaCollectionViewPlaceholderCell.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaCollectionViewPlaceholderCell.h"
#import "XZMocoaTableViewPlaceholderCell.h"
#import "XZMocoaCollectionViewSectionViewModel.h"
#import "XZMocoaCollectionView.h"

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
        backgroundView.backgroundColor = [UIColor colorWithRed:0xf2 / 255.0 green:0x3d / 255.0 blue:0x3a / 255.0 alpha:1.0];
        self.backgroundView = backgroundView;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.textColor = UIColor.whiteColor;
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.frame = UIEdgeInsetsInsetRect(self.bounds, self.layoutMargins);
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

- (void)collectionView:(XZMocoaCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [XZMocoaTableViewPlaceholderCell showAlertForView:collectionView model:self.viewModel.model reason:_reason detail:_detail];
}

@end
#endif
