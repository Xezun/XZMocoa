//
//  XZMocoaListityView.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaListityView.h"

@implementation XZMocoaListityView

#pragma mark - 属性

- (void)setViewModel:(__kindof XZMocoaListityViewModel *)viewModel {
    if (_viewModel != viewModel) {
        [self viewModelWillChange];
        // [_viewModel ready];
        _viewModel = viewModel;
        [self viewModelDidChange];
    }
}

- (void)viewModelWillChange {
    XZMocoaListityViewModel * const viewModel = self.viewModel;
    [self unregisterModule:viewModel.module];
    viewModel.delegate = nil;
}

- (void)viewModelDidChange {
    XZMocoaListityViewModel * const viewModel = self.viewModel;
    [self registerModule:viewModel.module];
    viewModel.delegate = self;
}

- (void)setContentView:(__kindof UIScrollView *)contentView {
    if (_contentView != contentView) {
        [self contentViewWillChange];
        
        [_contentView removeFromSuperview];
        _contentView = contentView;
        _contentView.frame = self.bounds;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_contentView];
        [self registerModule:self.viewModel.module];
        
        [self contentViewDidChange];
    }
}

- (void)contentViewWillChange {
    
}

- (void)contentViewDidChange {
    
}

- (void)unregisterModule:(XZMocoaModule *)module {
    @throw [NSException exceptionWithName:NSGenericException reason:@"必须使用子类，并重写此方法" userInfo:nil];
}

- (void)registerModule:(XZMocoaModule *)module {
    @throw [NSException exceptionWithName:NSGenericException reason:@"必须使用子类，并重写此方法" userInfo:nil];
}

@end

