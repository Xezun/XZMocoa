//
//  XZMocoaTableSectionViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaTableSectionViewModel.h"

@implementation XZMocoaTableSectionViewModel

- (XZMocoaTableSectionHeaderFooterViewModel *)headerViewModel {
    return [self viewModelForSupplementaryKind:XZMocoaKindHeader atIndex:0];
}

- (XZMocoaTableSectionHeaderFooterViewModel *)footerViewModel {
    return [self viewModelForSupplementaryKind:XZMocoaKindFooter atIndex:0];
}

- (CGFloat)height {
    CGFloat height = self.headerViewModel.height;
    for (XZMocoaTableCellViewModel *cellViewModel in self.cellViewModels) {
        height += cellViewModel.height;
    }
    height += self.footerViewModel.height;
    return height;
}

- (XZMocoaListityCellViewModel *)loadViewModelForCellAtIndex:(NSInteger)index {
    id<XZMocoaModel> const model   = [self.model modelForCellAtIndex:index];
    XZMocoaName      const name    = model.mocoaName;
    XZMocoaModule *  const module  = [self.module cellForName:name];
    Class            const VMClass = module.viewModelClass ?: [XZMocoaTableCellViewModel class];
    
    XZMocoaListityCellViewModel *vm = [[VMClass alloc] initWithModel:model];
    vm.index      = index;
    vm.module     = module;
    vm.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, XZMocoaKindCell, name);
    return vm;
}

- (__kindof XZMocoaListitySectionSupplementaryViewModel *)loadViewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    NSAssert(index == 0, @"UITableView 仅支持一个 %@ 类型的附加视图", kind);
    id<XZMocoaModel> model = [self.model modelForSupplementaryKind:kind atIndex:index];
    if (model == nil) {
        return nil;
    }
    XZMocoaName     const name    = model.mocoaName;
    XZMocoaModule * const module  = [self.module submoduleForKind:kind forName:name];
    Class           const VMClass = (^Class(Class aClass, XZMocoaKind kind) {
        if (aClass) return aClass;
        if ([kind isEqualToString:XZMocoaKindHeader]) return [XZMocoaTableSectionHeaderFooterViewModel class];
        if ([kind isEqualToString:XZMocoaKindFooter]) return [XZMocoaTableSectionHeaderFooterViewModel class];
        NSString *reason = [NSString stringWithFormat:@"UITableView 不支持 %@ 类型的子元素", kind];
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
    })(module.viewModelClass, kind);
    
    XZMocoaListitySectionSupplementaryViewModel *vm = [[VMClass alloc] initWithModel:model];
    vm.index      = index;
    vm.module     = module;
    vm.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, kind, name);
    return vm;
}

@end
