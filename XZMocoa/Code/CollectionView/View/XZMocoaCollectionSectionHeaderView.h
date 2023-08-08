//
//  XZMocoaCollectionSectionHeaderView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/8.
//

#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaCollectionSectionHeaderViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaCollectionSectionHeaderView <XZMocoaView>
@optional
@property (nonatomic, strong, nullable) __kindof XZMocoaCollectionSectionHeaderViewModel *viewModel;
@end

@interface XZMocoaCollectionSectionHeaderView : UICollectionReusableView <XZMocoaCollectionSectionHeaderView>
@end

NS_ASSUME_NONNULL_END
