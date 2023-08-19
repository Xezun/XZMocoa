//
//  XZMocoaTableSectionPlaceholderFooter.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaTableSectionPlaceholderFooter.h"

#if DEBUG
@implementation XZMocoaTableSectionPlaceholderFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        self.textLabel.font  = [UIFont systemFontOfSize:14.0];
        self.textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        self.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    }
    return self;
}

- (void)viewModelDidChange {
    XZMocoaTableSectionHeaderFooterViewModel *vm = self.viewModel;
    if (vm.module == nil) {
        self.textLabel.text = @"模块未注册";
    } else if (vm.module.viewClass == Nil) {
        self.textLabel.text = @"模块缺少 View 组件";
    } else {
        self.textLabel.text = @"模块缺少 ViewModel 组件";
    }
    id<XZMocoaModel> cell    = vm.model;
    id<XZMocoaModel> section = vm.superViewModel.model;
    XZMocoaName sectionName  = section.mocoaName ?: XZMocoaNameNone;
    XZMocoaName cellName     = cell.mocoaName ?: XZMocoaNameNone;
    self.detailTextLabel.text = [NSString stringWithFormat:@"section: %@, footer: %@", sectionName, cellName];
}
@end
#endif
