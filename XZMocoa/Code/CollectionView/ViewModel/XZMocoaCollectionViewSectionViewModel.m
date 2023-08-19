//
//  XZMocoaCollectionViewSectionViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaCollectionViewSectionViewModel.h"

@implementation XZMocoaCollectionViewSectionViewModel

- (__kindof XZMocoaCollectionViewSupplementaryViewModel *)viewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    return [super viewModelForSupplementaryKind:kind atIndex:index];
}

- (XZMocoaListityViewCellViewModel *)loadViewModelForCellAtIndex:(NSInteger)index {
    id<XZMocoaModel> const model   = [self.model modelForCellAtIndex:index];
    XZMocoaName      const name    = model.mocoaName;
    XZMocoaModule *  const module  = [self.module cellForName:name];
    Class            const VMClass = module.viewModelClass;
    
    XZMocoaCollectionViewCellViewModel *viewModel = nil;
    if (VMClass == Nil) {
        viewModel = [[XZMocoaCollectionViewCellViewModel alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(XZMocoaNamePlaceholder, XZMocoaKindPlaceholder, XZMocoaNamePlaceholder);
    } else {
        viewModel = [[VMClass alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, XZMocoaKindCell, name);
    }
    return viewModel;
}

- (__kindof XZMocoaListityViewSupplementaryViewModel *)loadViewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    id<XZMocoaModel> model = [self.model modelForSupplementaryKind:kind atIndex:index];
    if (model == nil) {
        return nil;
    }
    
    XZMocoaName     const name    = model.mocoaName;
    XZMocoaModule * const module  = [self.module submoduleForKind:kind forName:name];
    Class           const VMClass = module.viewModelClass;
    
    XZMocoaCollectionViewSupplementaryViewModel *viewModel = nil;
    if (VMClass == Nil) {
        viewModel = [[XZMocoaCollectionViewSupplementaryViewModel alloc] initWithModel:model];
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
