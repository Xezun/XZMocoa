//
//  Example21ContactEditorViewModel.m
//  Example
//
//  Created by Xezun on 2021/7/12.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactEditorViewModel.h"
#import "Example21Contact.h"

@implementation Example21ContactEditorViewModel

- (void)prepare {
    [super prepare];
    
    
}

- (NSString *)firstName {
    Example21Contact *model = self.model;
    return model.firstName;
}

- (NSString *)lastName {
    Example21Contact *model = self.model;
    return model.lastName;
}

- (NSString *)phone {
    Example21Contact *model = self.model;
    return model.phone;
}

- (void)setFirstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone {
    if (firstName.length == 0 || lastName.length == 0 || phone.length == 0) {
        return;
    }
    
    BOOL hasChanges = NO;
    Example21Contact *model = self.model;
    if (![firstName isEqualToString:model.firstName]) {
        model.firstName = firstName;
        hasChanges = YES;
    }
    if (![lastName isEqualToString:model.lastName]) {
        model.lastName  = lastName;
        hasChanges = YES;
    }
    if (![phone isEqualToString:model.phone]) {
        model.phone = phone;
        hasChanges = YES;
    }
    
    if (hasChanges) {
        [self emit:XZMocoaEmitNone value:nil];
    }
}

@end
