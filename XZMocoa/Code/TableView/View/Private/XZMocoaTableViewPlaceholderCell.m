//
//  XZMocoaTableViewPlaceholderCell.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import "XZMocoaTableViewPlaceholderCell.h"

#if DEBUG
@implementation XZMocoaTableViewPlaceholderCell {
    NSString *_reason;
    NSString *_detail;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0xf2 / 255.0 green:0x3d / 255.0 blue:0x3a / 255.0 alpha:1.0];
        self.backgroundView = backgroundView;
        
        self.selectionStyle              = UITableViewCellSelectionStyleNone;
        self.accessoryType               = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font              = [UIFont systemFontOfSize:14.0];
        self.textLabel.textColor         = UIColor.whiteColor;
        self.detailTextLabel.textColor   = UIColor.whiteColor;
    }
    return self;
}

- (void)viewModelDidChange {
    XZMocoaTableViewCellViewModel * const viewModel = self.viewModel;
    
    _reason = [XZMocoaTableViewPlaceholderCell reasonByCheckingModule:viewModel.module];
    
    XZMocoaName const cell    = ((id<XZMocoaModel>)viewModel.model).mocoaName ?: XZMocoaNameNone;
    XZMocoaName const section = ((id<XZMocoaModel>)viewModel.superViewModel.model).mocoaName ?: XZMocoaNameNone;
    _detail = [NSString stringWithFormat:@"section: %@, cell: %@", section, cell];
    
    self.textLabel.text = [NSString stringWithFormat:@"模块%@", _reason];
    self.detailTextLabel.text = _detail;
}

- (void)tableView:(XZMocoaTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [XZMocoaTableViewPlaceholderCell showAlertForView:tableView model:self.viewModel.model reason:_reason detail:_detail];
}

+ (NSString *)reasonByCheckingModule:(XZMocoaModule *)module {
    if (!module) {
        return @"不存在";
    }
    if (!module.modelClass && !module.viewClass && !module.viewModelClass) {
        return @"缺少 Model、View、ViewModel 组件";
    }
    if (!module.modelClass && !module.viewClass) {
        return @"缺少 Model、View 组件";
    }
    if (!module.modelClass && !module.viewModelClass) {
        return @"缺少 Model、ViewModel 组件";
    }
    if (!module.viewClass && !module.viewModelClass) {
        return @"缺少 View、ViewModel 组件";
    }
    if (!module.modelClass) {
        return @"缺少 Model 组件";
    }
    if (!module.viewClass) {
        return @"缺少 View 组件";
    }
    if (!module.viewModelClass) {
        return @"缺少 ViewModel 组件";
    }
    return @"不可用";
}

+ (void)showAlertForView:(id<XZMocoaView>)view model:(id)model reason:(NSString *)reason detail:(NSString *)detail {
    NSString *title = @"温馨提示";
    NSString *message = [NSString stringWithFormat:@"这是一个占位视图。\n因为目标视图对应的模块“%@”。\n请留意控制台，并检查相关代码。", reason];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil]];
    [view.viewController presentViewController:alertVC animated:YES completion:nil];
    NSLog(@"[XZMocoa] 数据 %@ 的视图所在的模块%@ %@", model, reason, detail);
}

@end
#endif
