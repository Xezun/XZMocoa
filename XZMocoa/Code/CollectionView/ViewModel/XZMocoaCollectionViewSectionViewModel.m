//
//  XZMocoaCollectionViewSectionViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaCollectionViewSectionViewModel.h"
#import "XZMocoaListityViewModel.h"

@implementation XZMocoaCollectionViewSectionViewModel

- (__kindof XZMocoaCollectionViewSupplementaryViewModel *)viewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    return [super viewModelForSupplementaryKind:kind atIndex:index];
}

- (XZMocoaListityViewCellViewModel *)loadViewModelForCellAtIndex:(NSInteger)index {
    XZMocoaName section = self.model.mocoaName;
    
    id<XZMocoaModel> const model   = [self.model modelForCellAtIndex:index];
    XZMocoaName      const name    = model.mocoaName;
    
    XZMocoaModule *module = [self.module submoduleIfLoadedForKind:XZMocoaKindCell forName:XZMocoaNameNone];
    if (module == nil && section.length > 0) {
        module = [self.superViewModel.module submoduleIfLoadedForKind:XZMocoaKindSection forName:XZMocoaNameNone];
        module = [module submoduleIfLoadedForKind:XZMocoaKindCell forName:name];
        section = XZMocoaNameNone;
    }
    Class const VMClass = module.viewModelClass;
    
    XZMocoaCollectionViewCellViewModel *viewModel = nil;
    if (VMClass == Nil) {
        viewModel = [[XZMocoaCollectionViewCellViewModel alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(XZMocoaNamePlaceholder, XZMocoaKindCell, XZMocoaNamePlaceholder);
    } else {
        viewModel = [[VMClass alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(section, XZMocoaKindCell, name);
    }
    return viewModel;
}

- (__kindof XZMocoaListityViewSupplementaryViewModel *)loadViewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    id<XZMocoaModel> model = [self.model modelForSupplementaryKind:kind atIndex:index];
    if (model == nil) {
        return nil;
    }
    
    XZMocoaName section = self.model.mocoaName;
    XZMocoaName const name = model.mocoaName;
    
    XZMocoaModule *module = [self.module submoduleIfLoadedForKind:kind forName:name];
    if (module == nil && section.length > 0) {
        module = [self.superViewModel.module submoduleIfLoadedForKind:XZMocoaKindSection forName:XZMocoaNameNone];
        module = [module submoduleIfLoadedForKind:kind forName:name];
        section = XZMocoaNameNone;
    }
    Class const VMClass = module.viewModelClass;
    
    XZMocoaCollectionViewSupplementaryViewModel *viewModel = nil;
    if (VMClass == Nil) {
        viewModel = [[XZMocoaCollectionViewSupplementaryViewModel alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(XZMocoaNamePlaceholder, kind, XZMocoaNamePlaceholder);
    } else {
        viewModel = [[VMClass alloc] initWithModel:model];
        viewModel.index      = index;
        viewModel.module     = module;
        viewModel.identifier = XZMocoaReuseIdentifier(section, kind, name);
    }
    return viewModel;
}

@end
