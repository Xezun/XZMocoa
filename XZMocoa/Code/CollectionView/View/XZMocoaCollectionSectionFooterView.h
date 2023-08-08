//
//  XZMocoaCollectionSectionFooterView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/8.
//

#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaCollectionSectionFooterViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaCollectionSectionFooterView <XZMocoaView>
@optional
@property (nonatomic, strong, nullable) __kindof XZMocoaCollectionSectionFooterViewModel *viewModel;
@end

@interface XZMocoaCollectionSectionFooterView : UICollectionReusableView <XZMocoaCollectionSectionFooterView>
@end

NS_ASSUME_NONNULL_END
