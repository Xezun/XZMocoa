//
//  XZMocoaTableSectionHeaderFooter.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaTableSectionHeaderFooterViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaTableSectionHeaderFooter <XZMocoaView>
@optional
@property (nonatomic, strong, nullable) __kindof XZMocoaTableSectionHeaderFooterViewModel *viewModel;
@end

/// 因一致性而提供，非必须基类。
/// @note 任何 UITableViewHeaderFooterView 对象都可以作为 Mocoa 的 View 实例，而非必须基于此类。
@interface XZMocoaTableSectionHeaderFooter : UITableViewHeaderFooterView <XZMocoaTableSectionHeaderFooter>
@end

NS_ASSUME_NONNULL_END
