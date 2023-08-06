//
//  XZMocoaCollectionSectionHeaderViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListitySectionHeaderViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionSectionHeaderViewModel : XZMocoaListitySectionHeaderViewModel
@property (nonatomic) CGSize size;
- (void)sizeDidChange;
@end

NS_ASSUME_NONNULL_END
