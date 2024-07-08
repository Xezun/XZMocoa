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
    mocoa_copyMethod(cls, @selector(wasSelectedInTableView:atIndexPath:), @selector(mocoa_wasSelectedInTableView:atIndexPath:));
    mocoa_copyMethod(cls, @selector(willBeDisplayedInTableView:atIndexPath:), @selector(mocoa_willBeDisplayedInTableView:atIndexPath:));
    mocoa_copyMethod(cls, @selector(didEndBeingDisplayedInTableView:atIndexPath:), @selector(mocoa_didEndBeingDisplayedInTableView:atIndexPath:));
}

- (void)mocoa_wasSelectedInTableView:(XZMocoaTableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel wasSelectedInTableView:tableView atIndexPath:indexPath];
}

- (void)mocoa_willBeDisplayedInTableView:(XZMocoaTableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel willBeDisplayedInTableView:tableView atIndexPath:indexPath];
}

- (void)mocoa_didEndBeingDisplayedInTableView:(XZMocoaTableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel didEndBeingDisplayedInTableView:tableView atIndexPath:indexPath];
}

@end


