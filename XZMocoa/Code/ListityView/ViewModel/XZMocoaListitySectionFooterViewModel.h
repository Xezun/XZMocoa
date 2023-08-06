//
//  XZMocoaListitySectionFooterViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/1/17.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoaDefines.h>
#import <XZMocoa/XZMocoaViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class XZMocoaListitySectionViewModel;

@interface XZMocoaListitySectionFooterViewModel : XZMocoaViewModel

/// 重用标识符。
@property (nonatomic, copy, XZ_READONLY) NSString *identifier;

@property (nonatomic) CGRect frame;

@end

NS_ASSUME_NONNULL_END
