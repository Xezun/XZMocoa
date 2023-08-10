//
//  Example22TextViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/9.
//

#import "Example22TextViewModel.h"
#import "Example22TextModel.h"

@implementation Example22TextViewModel

@dynamic model;
@synthesize name = _name;
@synthesize phone = _phone;

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/22/").section.cell.viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    [self loadData];
    self.size = CGSizeMake(150, 60.0);

}

- (void)loadData {
    Example22TextModel *model = self.model;
    _name  = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
    _phone = model.phone;
}

- (NSString *)name {
    Example22TextModel *model = self.model;
    return [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
}

- (NSString *)phone {
    Example22TextModel *model = self.model;
    return model.phone;
}

- (void)subViewModel:(__kindof XZMocoaViewModel *)subViewModel didEmit:(XZMocoaEmition *)emition {
    // 收到 editor 的 emit 事件。作为唯一下级，这里省略了对 subViewModel 的身份判定。
    // 由于与 target-action 使用了一样的名称，因此这里用了 emit.name 直接发送 target-action 事件。
    [self sendActionsForKeyEvents:emition.name];
}

- (void)wasSelectedInTableView:(XZMocoaTableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/examples/21/editor");
    UIViewController<XZMocoaView> *nextVC = [module instantiateViewControllerWithOptions:@{
        @"model": self.model
    }];
    // 添加为子模块，使用 emit 机制监听 name/phone 的变化
    [self addSubViewModel:nextVC.viewModel];
    [tableView.navigationController presentViewController:nextVC animated:YES completion:nil];
}
@end
