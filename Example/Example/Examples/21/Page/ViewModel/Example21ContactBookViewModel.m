//
//  Example21ContactBookViewModel.m
//  Example
//
//  Created by Xezun on 2021/4/12.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactBookViewModel.h"
#import "Example21ContactBook.h"

typedef NS_ENUM(NSUInteger, Example21ContactBookTestAction) {
    Example21ContactBookTestActionRestData = 0,
    Example21ContactBookTestActionSwitchList1,
    Example21ContactBookTestActionSwitchList2,
    Example21ContactBookTestActionSortByNameAsc,
    Example21ContactBookTestActionSortByNameDesc,
    Example21ContactBookTestActionSortByPhoneAsc,
    Example21ContactBookTestActionSortByPhoneDesc,
    Example21ContactBookTestActionInsertAtFirst,
    Example21ContactBookTestActionInsertAtMiddle,
    Example21ContactBookTestActionInsertAtLast,
    Example21ContactBookTestActionDeleteFirst,
    Example21ContactBookTestActionDeleteLast,
    Example21ContactBookTestActionDeleteRandom,
    Example21ContactBookTestActionDeleteAll,
};

@implementation Example21ContactBookViewModel {
    Example21ContactBook *_contactBook;
}

- (void)prepare {
    [super prepare];
    
    _contactBook = [[Example21ContactBook alloc] init];
    
    _tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:_contactBook];
    _tableViewModel.module = XZMocoa(@"https://mocoa.xezun.com/examples/21/");
    _tableViewModel.rowAnimation = UITableViewRowAnimationFade;
    [self addSubViewModel:_tableViewModel];
}

- (NSArray<NSString *> *)testActions {
    return @[
        @"恢复默认列表",
        @"列表切换测试-列表1", @"列表切换测试-列表2",
        @"姓名正序", @"姓名反序",
        @"号码正序", @"号码反序",
        @"在头部添加一个", @"在中间添加一个", @"在尾部添加一个",
        @"删除第一个", @"删除最后一个", @"随机删除一个",
        @"移除所有"
    ];
}

- (void)performTestActionAtIndex:(NSUInteger)index {
    [_tableViewModel performBatchUpdates:^{
        [self performTestAction:(Example21ContactBookTestAction)index];
    } completion:nil];
}

- (void)performTestAction:(Example21ContactBookTestAction)action {
    switch (action) {
        case Example21ContactBookTestActionRestData: {
            NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:10];
            for (NSInteger index = 0; index < 10; index++) {
                [contacts addObject:[Example21Contact contactForIndex:index]];
            }
            _contactBook.contacts = contacts;
            break;
        }
        case Example21ContactBookTestActionSwitchList1: {
            _contactBook.contacts = @[
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"A" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"B" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"C" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"D" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"E" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"F" phone:@"138-0000-0000"],
            ];
            break;
        }
        case Example21ContactBookTestActionSwitchList2: { // @"0", @"1", @"2", @"3", @"4", @"F", @"6", @"E", @"8", @"9", @"10", @"11", @"C"
            _contactBook.contacts = @[
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"0" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"1" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"2" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"3" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"4" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"F" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"6" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"E" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"8" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"9" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"10" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"11" phone:@"138-0000-0000"],
                [Example21Contact contactWithFirstName:@"TEST" lastName:@"C" phone:@"138-0000-0000"],
            ];
            break;
        }
        case Example21ContactBookTestActionSortByNameAsc: {
            _contactBook.contacts = [_contactBook.contacts sortedArrayUsingComparator:^NSComparisonResult(Example21Contact *obj1, Example21Contact *obj2) {
                return [obj1.firstName compare:obj2.firstName];
            }];
            break;
        }
        case Example21ContactBookTestActionSortByNameDesc: {
            _contactBook.contacts = [_contactBook.contacts sortedArrayUsingComparator:^NSComparisonResult(Example21Contact *obj1, Example21Contact *obj2) {
                return [obj1.firstName compare:obj2.firstName] * -1;
            }];
            break;
        }
        case Example21ContactBookTestActionSortByPhoneAsc: {
            _contactBook.contacts = [_contactBook.contacts sortedArrayUsingComparator:^NSComparisonResult(Example21Contact *obj1, Example21Contact *obj2) {
                return [obj1.phone compare:obj2.phone];
            }];
            break;
        }
        case Example21ContactBookTestActionSortByPhoneDesc: {
            _contactBook.contacts = [_contactBook.contacts sortedArrayUsingComparator:^NSComparisonResult(Example21Contact *obj1, Example21Contact *obj2) {
                return [obj1.phone compare:obj2.phone] * -1;
            }];
            break;
        }
        case Example21ContactBookTestActionInsertAtFirst: {
            Example21Contact *contact = [Example21Contact contactForIndex:_contactBook.contacts.count];
            if (contact == nil) {
                return;
            }
            
            NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:_contactBook.contacts.count + 1];
            [contacts addObject:contact];
            [contacts addObjectsFromArray:_contactBook.contacts];
            
            _contactBook.contacts = contacts;
            break;
        }
        case Example21ContactBookTestActionInsertAtMiddle: {
            Example21Contact *contact = [Example21Contact contactForIndex:_contactBook.contacts.count];
            if (contact == nil) {
                return;
            }
            
            NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:_contactBook.contacts.count + 1];
            [contacts addObjectsFromArray:_contactBook.contacts];
            
            if (_contactBook.contacts.count >= 2) {
                NSUInteger index = (NSUInteger)arc4random_uniform((uint32_t)_contactBook.contacts.count - 2) + 1;
                [contacts insertObject:contact atIndex:index];
            } else {
                [contacts addObject:contact];
            }
            
            _contactBook.contacts = contacts;
            break;
        }
        case Example21ContactBookTestActionInsertAtLast: {
            Example21Contact *contact = [Example21Contact contactForIndex:_contactBook.contacts.count];
            if (contact == nil) {
                return;
            }
            
            NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:_contactBook.contacts.count + 1];
            [contacts addObjectsFromArray:_contactBook.contacts];
            [contacts addObject:contact];
            
            _contactBook.contacts = contacts;
            break;
        }
        case Example21ContactBookTestActionDeleteFirst: {
            if (_contactBook.contacts.count == 0) {
                return;
            }
            NSRange range = NSMakeRange(1, _contactBook.contacts.count -1);
            _contactBook.contacts = [_contactBook.contacts subarrayWithRange:range];
            break;
        }
        case Example21ContactBookTestActionDeleteLast:
            if (_contactBook.contacts.count == 0) {
                return;
            }
            NSRange range = NSMakeRange(0, _contactBook.contacts.count -1);
            _contactBook.contacts = [_contactBook.contacts subarrayWithRange:range];
            break;
        case Example21ContactBookTestActionDeleteRandom: {
            if (_contactBook.contacts.count == 0) {
                return;
            }
            NSMutableArray *contacts = _contactBook.contacts.mutableCopy;
            NSUInteger index = (NSUInteger)arc4random_uniform((uint32_t)_contactBook.contacts.count - 2) + 1;
            [contacts removeObjectAtIndex:index];
            _contactBook.contacts = contacts;
            break;
        }
        case Example21ContactBookTestActionDeleteAll: {
            _contactBook.contacts = @[];
            break;
        }
        default:
            break;
    }
}

@end



        
