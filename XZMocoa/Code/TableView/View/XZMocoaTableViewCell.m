//
//  XZMocoaTableViewCell.m
//  XZMocoa
//
//  Created by Xezun on 2021/1/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaTableViewCell.h"
#import "XZMocoaModule.h"
#import "XZMocoaDefines.h"

@implementation XZMocoaTableViewCell
@dynamic viewModel;
@end


#import <objc/runtime.h>

static void mocoa_copyMethod(Class const cls, SEL const target, SEL const source) {
    if (xz_objc_class_copyMethod(cls, target, source)) return;
    XZLog(@"为协议 XZMocoaTableCell 的方法 %@ 提供默认实现失败", NSStringFromSelector(target));
}

@interface UITableViewCell (XZMocoaTableCell) <XZMocoaTableViewCell>
@end

@implementation UITableViewCell (XZMocoaTableCell)

@dynamic viewModel;

+ (void)load {
    Class const cls = UITableViewCell.class;
    mocoa_copyMethod(cls, @selector(tableView:didSelectRowAtIndexPath:), @selector(mocoa_tableView:didSelectRowAtIndexPath:));
    mocoa_copyMethod(cls, @selector(tableView:willDisplayRowAtIndexPath:), @selector(mocoa_tableView:willDisplayRowAtIndexPath:));
    mocoa_copyMethod(cls, @selector(tableView:didEndDisplayingRowAtIndexPath:), @selector(mocoa_tableView:didEndDisplayingRowAtIndexPath:));
}

- (void)mocoa_tableView:(XZMocoaTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)mocoa_tableView:(XZMocoaTableView *)tableView willDisplayRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel tableView:tableView willDisplayRowAtIndexPath:indexPath];
}

- (void)mocoa_tableView:(XZMocoaTableView *)tableView didEndDisplayingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel tableView:tableView didEndDisplayingRowAtIndexPath:indexPath];
}

@end


