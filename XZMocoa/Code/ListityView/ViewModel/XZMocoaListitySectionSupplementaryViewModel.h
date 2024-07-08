//
//  XZMocoaListitySectionSupplementaryViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import <XZMocoa/XZMocoaViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaListitySectionSupplementaryViewModel : XZMocoaViewModel
/// 重用标识符。
@property (nonatomic, copy, XZ_READONLY) NSString *identifier;
@property (nonatomic) CGRect frame;
@end

NS_ASSUME_NONNULL_END
