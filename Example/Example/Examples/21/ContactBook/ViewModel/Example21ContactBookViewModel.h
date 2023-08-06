//
//  Example21ContactBookViewModel.h
//  Example
//
//  Created by Xezun on 2021/4/12.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoa.h>
#import "Example21ContactBook.h"

NS_ASSUME_NONNULL_BEGIN

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

@interface Example21ContactBookViewModel : XZMocoaViewModel

@property (nonatomic, strong, readonly) XZMocoaTableViewModel *tableViewModel;
- (void)performAction:(Example21ContactBookTestAction)action;

@end

NS_ASSUME_NONNULL_END
