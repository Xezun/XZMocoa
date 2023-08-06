//
//  XZMocoaListitySectionHeaderViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/4/1.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoaViewModel.h>
#import <XZMocoa/XZMocoaDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaListitySectionHeaderViewModel : XZMocoaViewModel

/// 重用标识符。
@property (nonatomic, copy, XZ_READONLY) NSString *identifier;
@property (nonatomic) CGRect frame;
@end

NS_ASSUME_NONNULL_END
