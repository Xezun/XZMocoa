//
//  XZMocoaTableCellViewModel.h
//  
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityCellViewModel.h>

NS_ASSUME_NONNULL_BEGIN

/// UITableViewCell 视图模型基类。
@interface XZMocoaTableCellViewModel : XZMocoaListityCellViewModel
/// 视图高度。
@property (nonatomic) CGFloat height;

/// 当 height 属性发生变化时，此方法会被调用。
/// @note 默认情况下此方法直接触发观察者事件。
- (void)heightDidChange;

/// 当前 ViewModel 对应的 Cell 将要被选中时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)tableView:(UITableView *)tableView didSelectRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
/// 当前 ViewModel 对应的 Cell 将要被展示时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)tableView:(UITableView *)tableView willDisplayRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
/// 当前 ViewModel 对应的 Cell 将要被移除屏幕时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)tableView:(UITableView *)tableView didEndDisplayingRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
