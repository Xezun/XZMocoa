//
//  Example21ContactCellViewModel.h
//  Example
//
//  Created by Xezun on 2021/4/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoa.h>
#import "Example21ContactEditorViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example21ContactCellViewModel : XZMocoaTableCellViewModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, readonly) Example21ContactEditorViewModel *editorViewModel;

@end

NS_ASSUME_NONNULL_END
