//
//  XZMocoaTableViewSectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListViewSectionViewModel.h>
#import <XZMocoa/XZMocoaTableViewCellViewModel.h>
#import <XZMocoa/XZMocoaTableViewHeaderFooterViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaTableViewSectionViewModel : XZMocoaListViewSectionViewModel<XZMocoaTableViewCellViewModel *>

@property (nonatomic, readonly, nullable) XZMocoaTableViewHeaderFooterViewModel *headerViewModel;
@property (nonatomic, readonly, nullable) XZMocoaTableViewHeaderFooterViewModel *footerViewModel;
@property (nonatomic, readonly) CGFloat height;

@end

NS_ASSUME_NONNULL_END
