//
//  XZMocoaTableCell.m
//  XZMocoa
//
//  Created by Xezun on 2021/1/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaTableCell.h"
#import "XZMocoaModule.h"
#import "XZMocoaDefines.h"


@implementation XZMocoaTableCell
@dynamic viewModel;
@end


#import <objc/runtime.h>

static void mocoa_copyMethod(Class const cls, SEL const target, SEL const source) {
    if (xz_objc_class_copyMethod(cls, target, source)) return;
    XZLog(@"为协议 XZMocoaTableCell 的方法 %@ 提供默认实现失败", NSStringFromSelector(target));
}

@interface UITableViewCell (XZMocoaTableCell) <XZMocoaTableCell>
@end

@implementation UITableViewCell (XZMocoaTableCell)

@dynamic viewModel;

+ (void)load {
    Class const cls = UITableViewCell.class;
    mocoa_copyMethod(cls, @selector(tableView:didSelectRowAtIndexPath:), @selector(mocoa_tableView:didSelectRowAtIndexPath:));
    mocoa_copyMethod(cls, @selector(tableView:willDisplayRowAtIndexPath:), @selector(mocoa_tableView:willDisplayRowAtIndexPath:));
    mocoa_copyMethod(cls, @selector(tableView:didEndDisplayingRowAtIndexPath:), @selector(mocoa_tableView:didEndDisplayingRowAtIndexPath:));
}

- (void)mocoa_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel tableView:tableView didSelectRow:self atIndexPath:indexPath];
}

- (void)mocoa_tableView:(UITableView *)tableView willDisplayRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel tableView:tableView willDisplayRow:self atIndexPath:indexPath];
}

- (void)mocoa_tableView:(UITableView *)tableView didEndDisplayingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel tableView:tableView didEndDisplayingRow:self atIndexPath:indexPath];
}

@end


