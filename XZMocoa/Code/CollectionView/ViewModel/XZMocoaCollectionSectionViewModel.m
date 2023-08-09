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

- (XZMocoaListityCellViewModel *)loadViewModelForCellAtIndex:(NSInteger)index {
    id<XZMocoaModel> const model   = [self.model modelForCellAtIndex:index];
    XZMocoaName      const name    = model.mocoaName;
    XZMocoaModule *  const module  = [self.module cellForName:name];
    Class            const VMClass = module.viewModelClass ?: [XZMocoaCollectionCellViewModel class];
    
    XZMocoaListityCellViewModel *vm = [[VMClass alloc] initWithModel:model];
    vm.index      = index;
    vm.module     = module;
    vm.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, XZMocoaKindCell, name);
    return vm;
}

- (__kindof XZMocoaListitySectionSupplementaryViewModel *)loadViewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    id<XZMocoaModel> model = [self.model modelForSupplementaryKind:kind atIndex:index];
    if (model == nil) {
        return nil;
    }
    XZMocoaName     const name    = model.mocoaName;
    XZMocoaModule * const module  = [self.module submoduleForKind:kind forName:name];
    Class           const VMClass = module.viewModelClass ?: [XZMocoaCollectionSectionSupplementaryViewModel class];
    
    XZMocoaListitySectionSupplementaryViewModel *vm = [[VMClass alloc] initWithModel:model];
    vm.index      = index;
    vm.module     = module;
    vm.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, kind, name);
    return vm;
}

@end
