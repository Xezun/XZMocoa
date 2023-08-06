//
//  XZMocoaTableSectionViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaTableSectionViewModel.h"

@implementation XZMocoaTableSectionViewModel

- (CGFloat)height {
    CGFloat height = self.headerViewModel.height;
    for (XZMocoaTableCellViewModel *cellViewModel in self.cellViewModels) {
        height += cellViewModel.height;
    }
    height += self.footerViewModel.height;
    return height;
}

- (XZMocoaListitySectionHeaderViewModel *)loadHeaderViewModelWithModule:(XZMocoaModule *)headerModule model:(id)model {
    Class HeaderViewModel = headerModule.viewModelClass;
    if (HeaderViewModel == Nil) {
        HeaderViewModel = [XZMocoaTableSectionHeaderViewModel class];
    }
    return [[HeaderViewModel alloc] initWithModel:model];
}

- (XZMocoaListityCellViewModel *)loadCellViewModelWithModule:(XZMocoaModule *)cellModule model:(id)model {
    Class CellViewModel = cellModule.viewModelClass;
    if (CellViewModel == Nil) {
        CellViewModel = [XZMocoaTableCellViewModel class];
    }
    return [[CellViewModel alloc] initWithModel:model];
}

- (XZMocoaListitySectionFooterViewModel *)loadFooterViewModelWithModule:(XZMocoaModule *)footerModule model:(id)model {
    Class ViewModel = footerModule.viewModelClass;
    if (ViewModel == Nil) {
        ViewModel = [XZMocoaTableSectionFooterViewModel class];
    }
    return [[ViewModel alloc] initWithModel:model];
}

@end
