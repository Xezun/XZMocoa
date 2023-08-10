//
//  XZMocoaCollectionSectionSupplementaryView.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import "XZMocoaCollectionSectionSupplementaryView.h"

@implementation XZMocoaCollectionSectionSupplementaryView
@dynamic viewModel;
@end


#import <objc/runtime.h>

static void mocoa_copyMethod(Class const cls, SEL const target, SEL const source) {
    if (xz_objc_class_copyMethod(cls, target, source)) return;
    XZLog(@"为协议 XZMocoaCollectionSectionSupplementaryView 的方法 %@ 提供默认实现失败", NSStringFromSelector(target));
}

@interface UICollectionReusableView (XZMocoaCollectionSectionSupplementaryView) <XZMocoaCollectionSectionSupplementaryView>
@end

@implementation UICollectionReusableView (XZMocoaCollectionSectionSupplementaryView)

@dynamic viewModel;

+ (void)load {
    Class const cls = UICollectionReusableView.class;
    mocoa_copyMethod(cls, @selector(willBeDisplayedInCollectionView:atIndexPath:), @selector(mocoa_willBeDisplayedInCollectionView:atIndexPath:));
    mocoa_copyMethod(cls, @selector(didEndBeingDisplayedInCollectionView:atIndexPath:), @selector(mocoa_didEndBeingDisplayedInCollectionView:atIndexPath:));
}

- (void)mocoa_willBeDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel willBeDisplayedInCollectionView:collectionView atIndexPath:indexPath];
}

- (void)mocoa_didEndBeingDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel didEndBeingDisplayedInCollectionView:collectionView atIndexPath:indexPath];
}

@end
