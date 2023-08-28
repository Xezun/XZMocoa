//
//  XZMocoaTableViewPlaceholderHeaderFooterView.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaTableViewPlaceholderHeaderFooterView.h"
#import "XZMocoaTableViewSectionViewModel.h"
#import "XZMocoaListityPlaceholderView.h"

#if DEBUG
@implementation XZMocoaTableViewPlaceholderHeaderFooterView {
    XZMocoaListityPlaceholderView *_view;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _view = [[XZMocoaListityPlaceholderView alloc] initWithFrame:self.bounds];
        _view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_view];
    }
    return self;
}

- (void)viewModelDidChange {
    XZMocoaListityPlaceholderViewModel *viewModel = [[XZMocoaListityPlaceholderViewModel alloc] initWithModel:self.viewModel];
    [viewModel ready];
    _view.viewModel = viewModel;
}

@end
#endif
