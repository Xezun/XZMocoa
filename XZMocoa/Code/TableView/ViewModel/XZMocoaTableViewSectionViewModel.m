//
//  XZMocoaTableViewSectionViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaTableViewSectionViewModel.h"

@implementation XZMocoaTableViewSectionViewModel

- (XZMocoaTableViewHeaderFooterViewModel *)headerViewModel {
    return [self viewModelForSupplementaryKind:XZMocoaKindHeader atIndex:0];
}

- (XZMocoaTableViewHeaderFooterViewModel *)footerViewModel {
    return [self viewModelForSupplementaryKind:XZMocoaKindFooter atIndex:0];
}

- (CGFloat)height {
    CGFloat height = self.headerViewModel.height;
    for (XZMocoaTableViewCellViewModel *cellViewModel in self.cellViewModels) {
        height += cellViewModel.height;
    }
    height += self.footerViewModel.height;
    return height;
}

- (XZMocoaListityViewCellViewModel *)loadViewModelForCellAtIndex:(NSInteger)index {
    id<XZMocoaModel> const model   = [self.model modelForCellAtIndex:index];
    XZMocoaName      const name    = model.mocoaName;
    XZMocoaModule *  const module  = [self.module submoduleIfLoadedForKind:XZMocoaKindCell forName:name];
    Class            const VMClass = module.viewModelClass;
    
    XZMocoaListityViewCellViewModel *viewModel = nil;
    if (VMClass == Nil) {
        viewModel = [[XZMocoaTableViewCellViewModel alloc] initWithModel:model];
        viewModel.identifier = XZMocoaReuseIdentifier(XZMocoaNamePlaceholder, XZMocoaKindPlaceholder, XZMocoaNamePlaceholder);
        viewModel.index      = index;
        viewModel.module     = module;
    } else {
        viewModel = [[VMClass alloc] initWithModel:model];
        viewModel.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, XZMocoaKindCell, name);
        viewModel.index      = index;
        viewModel.module     = module;
    }
    return viewModel;
}

- (__kindof XZMocoaListityViewSupplementaryViewModel *)loadViewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    NSAssert(index == 0, @"UITableView 仅支持一个 %@ 类型的附加视图", kind);
    id<XZMocoaModel> const model = [self.model modelForSupplementaryKind:kind atIndex:index];
    
    if (model == nil) {
        return nil; // 没有数据，就没有 header/footer
    }
    
    XZMocoaName     const name    = model.mocoaName;
    XZMocoaModule * const module  = [self.module submoduleIfLoadedForKind:kind forName:name];
    Class           const VMClass = module.viewModelClass;
    
    XZMocoaListityViewSupplementaryViewModel *viewModel = nil;
    if (VMClass == Nil) {
        viewModel = [[XZMocoaTableViewHeaderFooterViewModel alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(XZMocoaNamePlaceholder, XZMocoaKindPlaceholder, XZMocoaNamePlaceholder);
    } else {
        viewModel = [[VMClass alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, kind, name);
    }
    return viewModel;
}

@end
