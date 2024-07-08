//
//  Example21ContactBook.h
//  Example
//
//  Created by Xezun on 2021/4/26.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoa.h>
#import "Example21Contact.h"

NS_ASSUME_NONNULL_BEGIN

@class Example21ContactBook;

@interface Example21ContactBook : NSObject <XZMocoaModel, XZMocoaTableModel, XZMocoaTableViewSectionModel>

@property (nonatomic, copy) NSArray *contacts;

@end

NS_ASSUME_NONNULL_END
