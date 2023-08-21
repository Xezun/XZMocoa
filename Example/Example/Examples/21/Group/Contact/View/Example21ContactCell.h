//
//  Example21ContactCell.h
//  Example
//
//  Created by Xezun on 2021/4/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoa.h>
#import "Example21ContactCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example21ContactCell : XZMocoaTableViewCell

@property (nonatomic, strong, nullable) Example21ContactCellViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
