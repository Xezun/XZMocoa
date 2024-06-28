//
//  Example21ContactBook.m
//  Example
//
//  Created by Xezun on 2021/4/26.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactBook.h"
#import "Example21Contact.h"

@implementation Example21ContactBook

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
        for (NSInteger i = 0; i < 10; i++) {
            [arrayM addObject:[Example21Contact contactForIndex:i]];
        }
        _contacts = arrayM.copy;
    }
    return self;
}

#pragma mark - XZMocoaTableModel

- (NSInteger)numberOfSectionModels {
    return 1;
}

- (id<XZMocoaAssembleViewSectionModel>)modelForSectionAtIndex:(NSInteger)index {
    return self;
}

#pragma mark - XZMocoaTableViewSectionModel

- (id)headerModel {
    return nil;
}

- (id)footerModel {
    return nil;
}

- (NSInteger)numberOfCellModels {
    return _contacts.count;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return _contacts[index];
}

@end
