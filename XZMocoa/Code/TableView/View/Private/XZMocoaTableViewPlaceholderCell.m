//
//  XZMocoaTableViewPlaceholderCell.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaTableViewPlaceholderCell.h"

#if DEBUG
@implementation XZMocoaTableViewPlaceholderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font  = [UIFont systemFontOfSize:14.0];
        self.textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        self.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    }
    return self;
}

- (void)viewModelDidChange {
    XZMocoaTableCellViewModel *vm = self.viewModel;
    
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
    self.detailTextLabel.text = [NSString stringWithFormat:@"section: %@, cell: %@", sectionName, cellName];
}

- (void)tableView:(XZMocoaTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = @"温馨提示";
    NSString *message = [NSString stringWithFormat:@"这是一个占位视图，因为目标视图对应的“%@”，请检查相关代码。\n占位视图仅在 DEBUG 环境展示。", self.textLabel.text];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil]];
    [tableView.viewController presentViewController:alertVC animated:YES completion:nil];
}

@end
#endif
