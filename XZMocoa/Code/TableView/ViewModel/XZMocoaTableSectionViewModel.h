//
//  XZMocoaTableSectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListitySectionViewModel.h>
#import <XZMocoa/XZMocoaTableViewCellViewModel.h>
#import <XZMocoa/XZMocoaTableSectionHeaderFooterViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaTableSectionViewModel : XZMocoaListitySectionViewModel<XZMocoaTableViewCellViewModel *>

@property (nonatomic, readonly, nullable) XZMocoaTableSectionHeaderFooterViewModel *headerViewModel;
@property (nonatomic, readonly, nullable) XZMocoaTableSectionHeaderFooterViewModel *footerViewModel;
@property (nonatomic, readonly) CGFloat height;

@end

NS_ASSUME_NONNULL_END
