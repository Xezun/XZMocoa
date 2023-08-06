//
//  Example21ContactCellViewModel.m
//  Example
//
//  Created by Xezun on 2021/4/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactCellViewModel.h"
#import "Example21ContactEditorViewModel.h"

@implementation Example21ContactCellViewModel

@dynamic model;
@synthesize name = _name;
@synthesize phone = _phone;

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/21/").section.cell.viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    _name  = [NSString stringWithFormat:@"%@ %@", self.model.firstName, self.model.lastName];
    _phone = self.model.phone;
    
    self.height = 44.0;
}

- (void)setName:(NSString *)name {
    if (![_name isEqualToString:name]) {
        _name = name.copy;
        [self sendActionsForKeyEvent:@"name"];
    }
}

- (void)setPhone:(NSString *)phone {
    if (![_phone isEqualToString:phone]) {
        _phone = phone.copy;
        [self sendActionsForKeyEvent:@"phone"];
    }
}

- (Example21ContactEditorViewModel *)editorViewModel {
    return self;
}

@end
