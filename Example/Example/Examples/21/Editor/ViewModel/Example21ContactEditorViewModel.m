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

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/21/editor").viewModelClass = self;
}

- (void)dealloc {
    XZLog(@"EditorViewModel: %@", self);
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
    
    Example21Contact *model = self.model;
    
    if (![firstName isEqualToString:model.firstName] || ![lastName isEqualToString:model.lastName]) {
        model.firstName = firstName;
        model.lastName  = lastName;
        [self emit:@"name" value:nil];
    }

    if (![phone isEqualToString:model.phone]) {
        model.phone = phone;
        [self emit:@"phone" value:nil];
    }
}

@end
