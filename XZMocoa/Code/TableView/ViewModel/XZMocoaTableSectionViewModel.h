//
//  XZMocoaTableSectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListitySectionViewModel.h>
#import <XZMocoa/XZMocoaTableCellViewModel.h>
#import <XZMocoa/XZMocoaTableSectionViewModel.h>
#import <XZMocoa/XZMocoaTableSectionHeaderViewModel.h>
#import <XZMocoa/XZMocoaTableSectionFooterViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaTableSectionViewModel : XZMocoaListitySectionViewModel<XZMocoaTableSectionHeaderViewModel *, XZMocoaTableSectionFooterViewModel *, XZMocoaTableCellViewModel *>

@property (nonatomic, readonly) CGFloat height;

@end

NS_ASSUME_NONNULL_END
