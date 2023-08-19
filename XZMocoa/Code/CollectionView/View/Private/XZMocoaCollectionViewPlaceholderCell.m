//
//  XZMocoaCollectionViewPlaceholderCell.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaCollectionViewPlaceholderCell.h"

#if DEBUG
@implementation XZMocoaCollectionViewPlaceholderCell

- (void)viewModelDidChange {
    XZMocoaCollectionViewCellViewModel * const viewModel = self.viewModel;
    XZMocoaCollectionViewSectionViewModel * const superViewModel = viewModel.superViewModel;
    
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
    
    NSLog(@"%@ section: %@, cell: %@", reason, section, cell);
}

@end
#endif
