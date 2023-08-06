//
//  XZMocoaListityCellViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/1/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoaDefines.h>
#import <XZMocoa/XZMocoaViewModel.h>

NS_ASSUME_NONNULL_BEGIN

/// cell 视图模型基类。
@interface XZMocoaListityCellViewModel : XZMocoaViewModel
/// 重用标识符。
@property (nonatomic, copy, XZ_READONLY) NSString *identifier;
@property (nonatomic) CGRect frame;
@end

NS_ASSUME_NONNULL_END
