//
//  XZMocoaTableView.m
//  XZMocoa
//
//  Created by Xezun on 2021/3/24.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaTableView.h"
#import "XZMocoaDefines.h"
#import "XZMocoaTableCell.h"
#import "XZMocoaTableSectionHeaderFooter.h"
#import "XZMocoaTableSectionHeaderFooter.h"

@interface XZMocoaTableView ()
@end

@implementation XZMocoaTableView

@dynamic viewModel, contentView;

- (instancetype)initWithCoder:(NSCoder *)coder {
    return [super initWithCoder:coder];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self initWithFrame:UIScreen.mainScreen.bounds style:style];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [self initWithTableViewClass:UITableView.class style:style];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithTableViewClass:UITableView.class style:(UITableViewStylePlain)];
}

- (instancetype)initWithTableViewClass:(Class)tableViewClass style:(UITableViewStyle)style {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        UITableView *contentView = [[tableViewClass alloc] initWithFrame:self.bounds style:style];
        [super setContentView:contentView];
    }
    return self;
}

- (void)contentViewWillChange {
    [super contentViewWillChange];
    
    UITableView *contentView = self.contentView;
    contentView.delegate = nil;
    contentView.dataSource = nil;
}

- (void)contentViewDidChange {
    [super contentViewDidChange];
    
    UITableView *contentView = self.contentView;
    contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentView.contentInset   = UIEdgeInsetsZero;
    
    contentView.estimatedRowHeight = 0;
    contentView.estimatedSectionFooterHeight = 0;
    contentView.estimatedSectionHeaderHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    contentView.delegate   = self;
    contentView.dataSource = self;
}

- (void)viewModelDidChange {
    [super viewModelDidChange];
    
    // 刷新视图。
    UITableView * const tableView = self.contentView;
    if (@available(iOS 11.0, *)) {
        if (tableView && !tableView.hasUncommittedUpdates) {
            [tableView reloadData];
        }
    } else {
        [tableView reloadData];
    }
}

- (void)registerModule:(XZMocoaModule *)module {
    UITableView * const tableView = self.contentView;
    if (!module || !self.contentView) {
        return;
    }
    
    { // 注册默认的 cell 视图
        NSString *identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaKindCell, XZMocoaNameNone);
        [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:identifier];
    }
    
    [module enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName section, BOOL *stop) {
        if (![kind isEqualToString:XZMocoaKindSection]) {
            return; // 不是 section 的 module 不需要处理
        }

        [submodule enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName name, BOOL *stop) {
            if ([kind isEqualToString:XZMocoaKindCell]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, XZMocoaKindCell, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [tableView registerNib:viewNib forCellReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [tableView registerClass:submodule.viewClass forCellReuseIdentifier:identifier];
                }
            } else if ([kind isEqualToString:XZMocoaKindHeader]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, XZMocoaKindCell, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [tableView registerNib:viewNib forHeaderFooterViewReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [tableView registerClass:submodule.viewClass forHeaderFooterViewReuseIdentifier:identifier];
                }
            } else if ([kind isEqualToString:XZMocoaKindFooter]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, XZMocoaKindCell, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [tableView registerNib:viewNib forHeaderFooterViewReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [tableView registerClass:submodule.viewClass forHeaderFooterViewReuseIdentifier:identifier];
                }
            }
        }];
    }];
}

- (void)unregisterModule:(XZMocoaModule *)module {
    // 由于标识符一样的会被覆盖，理论上即使不解除注册，也不会有什么影响。
}

@end



@implementation XZMocoaTableView (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfCellsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XZMocoaTableCellViewModel * const viewModel = [self.viewModel cellViewModelAtIndexPath:indexPath];
    
#if DEBUG
    UITableViewCell<XZMocoaTableCell> *cell = [tableView dequeueReusableCellWithIdentifier:viewModel.identifier forIndexPath:indexPath];
#else
    UITableViewCell<XZMocoaTableCell> *cell = [tableView dequeueReusableCellWithIdentifier:viewModel.identifier];
    if (cell == nil) {
        cell = (id)[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:viewModel.identifier];
    }
#endif
    
    cell.viewModel = viewModel;
    
    return cell;
}

@end


@implementation XZMocoaTableView (UIScrollViewDelegate)
@end


@implementation XZMocoaTableView (UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XZMocoaTableCellViewModel * const viewModel = [self.viewModel cellViewModelAtIndexPath:indexPath];
    return viewModel.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XZMocoaTableSectionHeaderFooterViewModel * const viewModel = [self.viewModel sectionViewModelAtIndex:section].headerViewModel;
    if (viewModel == nil) {
        return nil;
    }
    UITableViewHeaderFooterView<XZMocoaTableSectionHeaderFooter> *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewModel.identifier];
    view.viewModel = viewModel;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    XZMocoaTableSectionHeaderFooterViewModel * const viewModel = [self.viewModel sectionViewModelAtIndex:section].headerViewModel;
    if (viewModel == nil) {
        return XZMocoaTableViewHeaderFooterHeight;
    }
    return viewModel.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    XZMocoaTableSectionHeaderFooterViewModel * const viewModel = [self.viewModel sectionViewModelAtIndex:section].footerViewModel;
    if (viewModel == nil) {
        return nil;
    }
    UITableViewHeaderFooterView<XZMocoaTableSectionHeaderFooter> *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewModel.identifier];
    view.viewModel = viewModel;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    XZMocoaTableSectionHeaderFooterViewModel * const viewModel = [self.viewModel sectionViewModelAtIndex:section].footerViewModel;
    if (viewModel == nil) {
        return XZMocoaTableViewHeaderFooterHeight;
    }
    return viewModel.height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableView<XZMocoaTableCell> *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell willBeDisplayedInTableView:self atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableView<XZMocoaTableCell> *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    [cell didEndBeingDisplayedInTableView:self atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableView<XZMocoaTableCell> *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    [cell wasSelectedInTableView:self atIndexPath:indexPath];
}

@end


@implementation XZMocoaTableView (XZMocoaTableViewModelDelegate)

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didReloadData:(void *)foo {
    [self.contentView reloadData];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didReloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    UITableViewRowAnimation const rowAnimation = tableViewModel.rowAnimation;
    [self.contentView reloadRowsAtIndexPaths:indexPaths withRowAnimation:rowAnimation];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didInsertCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    UITableViewRowAnimation const rowAnimation = tableViewModel.rowAnimation;
    [self.contentView insertRowsAtIndexPaths:indexPaths withRowAnimation:rowAnimation];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didDeleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    UITableViewRowAnimation const rowAnimation = tableViewModel.rowAnimation;
    [self.contentView deleteRowsAtIndexPaths:indexPaths withRowAnimation:rowAnimation];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didMoveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    [self.contentView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didReloadSectionsAtIndexes:(NSIndexSet *)sections {
    UITableViewRowAnimation const rowAnimation = tableViewModel.rowAnimation;
    [self.contentView reloadSections:sections withRowAnimation:rowAnimation];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didDeleteSectionsAtIndexes:(NSIndexSet *)sections {
    UITableViewRowAnimation const rowAnimation = tableViewModel.rowAnimation;
    [self.contentView deleteSections:sections withRowAnimation:rowAnimation];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didInsertSectionsAtIndexes:(NSIndexSet *)sections {
    UITableViewRowAnimation const rowAnimation = tableViewModel.rowAnimation;
    [self.contentView insertSections:sections withRowAnimation:rowAnimation];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didMoveSectionAtIndex:(NSInteger)section toIndex:(NSInteger)newSection {
    [self.contentView moveSection:section toSection:newSection];
}

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL))completion {
    if (@available(iOS 11.0, *)) {
        [self.contentView performBatchUpdates:batchUpdates completion:completion];
    } else {
        [self.contentView beginUpdates];
        batchUpdates();
        [self.contentView endUpdates];
        if (completion) dispatch_async(dispatch_get_main_queue(), ^{ completion(YES); });
    }
}

@end
