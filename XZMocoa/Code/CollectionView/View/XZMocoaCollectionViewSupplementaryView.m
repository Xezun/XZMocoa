//
//  XZMocoaCollectionViewSupplementaryView.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import "XZMocoaCollectionViewSupplementaryView.h"

@implementation XZMocoaCollectionViewSupplementaryView
@dynamic viewModel;
@end


#import <objc/runtime.h>

static void mocoa_copyMethod(Class const cls, SEL const target, SEL const source) {
    if (xz_objc_class_copyMethod(cls, target, source)) return;
    XZLog(@"为协议 XZMocoaCollectionViewSupplementaryView 的方法 %@ 提供默认实现失败", NSStringFromSelector(target));
}

@interface UICollectionReusableView (XZMocoaCollectionViewSupplementaryView) <XZMocoaCollectionViewSupplementaryView>
@end

@implementation UICollectionReusableView (XZMocoaCollectionViewSupplementaryView)

@dynamic viewModel;

+ (void)load {
    Class const cls = UICollectionReusableView.class;
    mocoa_copyMethod(cls, @selector(collectionView:willDisplaySupplementaryViewAtIndexPath:), @selector(mocoa_collectionView:willDisplaySupplementaryViewAtIndexPath:));
    mocoa_copyMethod(cls, @selector(collectionView:didEndDisplayingSupplementaryViewAtIndexPath:), @selector(mocoa_collectionView:didEndDisplayingSupplementaryViewAtIndexPath:));
}

- (void)mocoa_collectionView:(XZMocoaCollectionView *)collectionView willDisplaySupplementaryViewAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView willDisplaySupplementaryViewAtIndexPath:indexPath];
}

- (void)mocoa_collectionView:(XZMocoaCollectionView *)collectionView didEndDisplayingSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView didEndDisplayingSupplementaryViewAtIndexPath:indexPath];
}

@end
