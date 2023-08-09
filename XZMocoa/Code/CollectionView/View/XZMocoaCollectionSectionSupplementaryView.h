//
//  XZMocoaCollectionSectionSupplementaryView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaCollectionSectionSupplementaryViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaCollectionSectionSupplementaryView <XZMocoaView>
@optional
@property (nonatomic, strong, nullable) __kindof XZMocoaCollectionSectionSupplementaryViewModel *viewModel;
@end

@interface XZMocoaCollectionSectionSupplementaryView : UICollectionReusableView <XZMocoaCollectionSectionSupplementaryView>

@end

NS_ASSUME_NONNULL_END
