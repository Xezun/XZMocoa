//
//  XZMocoaCollectionSectionViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaCollectionSectionViewModel.h"

@implementation XZMocoaCollectionSectionViewModel

- (__kindof XZMocoaCollectionSectionSupplementaryViewModel *)viewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    return [super viewModelForSupplementaryKind:kind atIndex:index];
}

- (XZMocoaListityViewCellViewModel *)loadViewModelForCellAtIndex:(NSInteger)index {
    id<XZMocoaModel> const model   = [self.model modelForCellAtIndex:index];
    XZMocoaName      const name    = model.mocoaName;
    XZMocoaModule *  const module  = [self.module cellForName:name];
    Class            const VMClass = module.viewModelClass;
    
    XZMocoaCollectionCellViewModel *viewModel = nil;
    if (VMClass == Nil) {
        viewModel = [[XZMocoaCollectionCellViewModel alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaKindCell, XZMocoaNameNone);
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
    
    XZMocoaName     const name      = model.mocoaName;
    XZMocoaModule * const module    = [self.module submoduleForKind:kind forName:name];
    Class           const ViewModel = module.viewModelClass;
    
    XZMocoaCollectionSectionSupplementaryViewModel *viewModel = nil;
    if (module == nil) {
        viewModel = [[XZMocoaCollectionSectionSupplementaryViewModel alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, kind, XZMocoaNameNone);
    } else {
        viewModel = [[ViewModel alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, kind, name);
    }
    return viewModel;
}

@end
