//
//  Example21ContactCellViewModel.m
//  Example
//
//  Created by Xezun on 2021/4/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactCellViewModel.h"
#import "Example21ContactEditorViewModel.h"
#import "Example21Contact.h"
#import "Example21ContactEditor.h"

@implementation Example21ContactCellViewModel

@dynamic model;
@synthesize name = _name;
@synthesize phone = _phone;

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/21/").section.cell.viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    [self loadData];
    self.height = 44.0;
}

- (void)loadData {
    Example21Contact *model = self.model;
    _name  = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
    _phone = model.phone;
}

- (void)subViewModel:(__kindof XZMocoaViewModel *)subViewModel didEmit:(XZMocoaEmit)emit {
    if (subViewModel == _editorViewModel) {
        [self loadData];
        [self sendActionsForKeyEvents:@"name"];
        [self sendActionsForKeyEvents:@"phone"];
    }
}

- (void)tableView:(UITableView<XZMocoaView> *)tableView didSelectRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Example21ContactEditor *next = [[Example21ContactEditor alloc] init];
    next.viewModel = self.editorViewModel;
    [tableView.navigationController presentViewController:next animated:YES completion:nil];
}

@synthesize editorViewModel = _editorViewModel;

- (Example21ContactEditorViewModel *)editorViewModel {
    if (_editorViewModel == nil) {
        _editorViewModel = [[Example21ContactEditorViewModel alloc] initWithModel:self.model];
        [self addSubViewModel:_editorViewModel];
    }
    return _editorViewModel;
}

@end
