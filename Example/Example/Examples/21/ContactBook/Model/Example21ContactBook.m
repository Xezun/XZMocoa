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
        _contacts = @[
            [Example21Contact contactWithFirstName:@"01" lastName:@"张三" phone:@"158-6279-2379"],
            [Example21Contact contactWithFirstName:@"02" lastName:@"李四" phone:@"154-6244-8638"],
            [Example21Contact contactWithFirstName:@"03" lastName:@"王五" phone:@"153-9983-9661"],
            [Example21Contact contactWithFirstName:@"04" lastName:@"赵六" phone:@"177-3603-3490"],
            [Example21Contact contactWithFirstName:@"05" lastName:@"梁苹" phone:@"152-9421-0481"],
            [Example21Contact contactWithFirstName:@"06" lastName:@"龚倪" phone:@"156-6750-7774"],
            [Example21Contact contactWithFirstName:@"07" lastName:@"任妃" phone:@"137-2066-7555"],
            [Example21Contact contactWithFirstName:@"08" lastName:@"文娅" phone:@"130-3153-4241"],
            [Example21Contact contactWithFirstName:@"09" lastName:@"邓碧" phone:@"188-3299-3516"],
            [Example21Contact contactWithFirstName:@"10" lastName:@"易茗" phone:@"187-9451-0608"],
        ];
    }
    return self;
}

#pragma mark - XZMocoaTableModel

- (NSInteger)numberOfSectionModels {
    return 1;
}

- (id<XZMocoaListitySectionModel>)modelForSectionAtIndex:(NSInteger)index {
    return self;
}

#pragma mark - XZMocoaTableSectionModel

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
