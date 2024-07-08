//
//  XZMocoaTableCellViewModel.h
//  
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityCellViewModel.h>

@class XZMocoaTableView;

NS_ASSUME_NONNULL_BEGIN

/// UITableViewCell 视图模型基类。
@interface XZMocoaTableCellViewModel : XZMocoaListityCellViewModel

/// 视图高度。
@property (nonatomic) CGFloat height;

/// 当前 ViewModel 对应的 Cell 将要被选中时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)wasSelectedInTableView:(XZMocoaTableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
/// 当前 ViewModel 对应的 Cell 将要被展示时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)willBeDisplayedInTableView:(XZMocoaTableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
/// 当前 ViewModel 对应的 Cell 将要被移除屏幕时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)didEndBeingDisplayedInTableView:(XZMocoaTableView *)tableView atIndexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
