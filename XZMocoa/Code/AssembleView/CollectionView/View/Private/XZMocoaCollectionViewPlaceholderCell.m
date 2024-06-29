//
//  XZMocoaCollectionViewPlaceholderCell.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaCollectionViewPlaceholderCell.h"
#import "XZMocoaAssemblePlaceholderView.h"
#import "XZMocoaCollectionViewSectionViewModel.h"
#import "XZMocoaCollectionView.h"

#if DEBUG
@implementation XZMocoaCollectionViewPlaceholderCell {
    XZMocoaAssemblePlaceholderView *_view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[XZMocoaAssemblePlaceholderView alloc] initWithFrame:self.bounds];
        _view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_view];
    }
    return self;
}

- (void)viewModelDidChange {
    XZMocoaAssemblePlaceholderViewModel *viewModel = [[XZMocoaAssemblePlaceholderViewModel alloc] initWithModel:self.viewModel];
    [viewModel ready];
    _view.viewModel = viewModel;
}

@end
#endif
