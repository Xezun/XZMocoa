//
//  XZMocoaCollectionReusableView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/8.
//

#import <XZMocoa/XZMocoaView.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaCollectionReusableView <XZMocoaView>
@optional
//@property (nonatomic, strong, nullable) __kindof XZMocoaTableSectionHeaderFooterViewModel *viewModel;
@end

@interface XZMocoaCollectionReusableView : UICollectionReusableView <XZMocoaCollectionReusableView>

@end

NS_ASSUME_NONNULL_END
