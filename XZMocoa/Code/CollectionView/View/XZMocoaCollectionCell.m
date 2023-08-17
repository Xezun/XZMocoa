//
//  XZMocoaCollectionCell.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/23.
//

#import "XZMocoaCollectionCell.h"
#import "XZMocoaModule.h"
#import "XZMocoaDefines.h"


@implementation XZMocoaCollectionCell
@dynamic viewModel;
@end

#import <objc/runtime.h>

static void mocoa_copyMethod(Class const cls, SEL const target, SEL const source) {
    if (xz_objc_class_copyMethod(cls, target, source)) return;
    XZLog(@"为协议 XZMocoaCollectionCell 的方法 %@ 提供默认实现失败", NSStringFromSelector(target));
}

@interface UICollectionViewCell (XZMocoaCollectionCell) <XZMocoaCollectionCell>
@end

@implementation UICollectionViewCell (XZMocoaCollectionCell)

@dynamic viewModel;

+ (void)load {
    Class const cls = UICollectionViewCell.class;
    mocoa_copyMethod(cls, @selector(collectionView:didSelectItemAtIndexPath:), @selector(mocoa_collectionView:didSelectItemAtIndexPath:));
    mocoa_copyMethod(cls, @selector(collectionView:willDisplayItemAtIndexPath:), @selector(mocoa_collectionView:willDisplayItemAtIndexPath:));
    mocoa_copyMethod(cls, @selector(collectionView:didEndDisplayingItemAtIndexPath:), @selector(mocoa_collectionView:didEndDisplayingItemAtIndexPath:));
}

- (void)mocoa_collectionView:(XZMocoaCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)mocoa_collectionView:(XZMocoaCollectionView *)collectionView willDisplayItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView willDisplayItemAtIndexPath:indexPath];
}

- (void)mocoa_collectionView:(XZMocoaCollectionView *)collectionView didEndDisplayingItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView didEndDisplayingItemAtIndexPath:indexPath];
}

@end
