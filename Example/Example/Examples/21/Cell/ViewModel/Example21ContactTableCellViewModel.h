//
//  Example21ContactCellViewModel.h
//  Example
//
//  Created by Xezun on 2021/4/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoa.h>
#import "Example21Contact.h"

NS_ASSUME_NONNULL_BEGIN

@class Example21ContactCellViewModel;
typedef Example21ContactCellViewModel Example21ContactEditorViewModel;

@interface Example21ContactCellViewModel : XZMocoaTableCellViewModel

@property (nonatomic, strong, readonly, nullable) Example21Contact *model;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, readonly) Example21ContactEditorViewModel *editorViewModel;

@end

NS_ASSUME_NONNULL_END
