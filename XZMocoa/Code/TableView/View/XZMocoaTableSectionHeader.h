//
//  XZMocoaTableSectionHeader.h
//  XZMocoa
//
//  Created by Xezun on 2021/4/1.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaTableSectionHeaderViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaTableSectionHeader <XZMocoaView>
@optional
@property (nonatomic, strong, nullable) __kindof XZMocoaTableSectionHeaderViewModel *viewModel;
@end


/// 因一致性而提供，非必须基类。
/// @note 任何 UITableViewHeaderFooterView 对象都可以作为 Mocoa 的 View 实例，而非必须基于此类。
@interface XZMocoaTableSectionHeader : UITableViewHeaderFooterView
@end
NS_ASSUME_NONNULL_END
