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
    mocoa_copyMethod(cls, @selector(collectionView:didSelectRowAtIndexPath:), @selector(mocoa_collectionView:didSelectRowAtIndexPath:));
    mocoa_copyMethod(cls, @selector(collectionView:willDisplayRowAtIndexPath:), @selector(mocoa_collectionView:willDisplayRowAtIndexPath:));
    mocoa_copyMethod(cls, @selector(collectionView:didEndDisplayingRowAtIndexPath:), @selector(mocoa_collectionView:didEndDisplayingRowAtIndexPath:));
}

- (void)mocoa_collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView didSelectRow:self atIndexPath:indexPath];
}

- (void)mocoa_collectionView:(UICollectionView *)collectionView willDisplayRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView willDisplayRow:self atIndexPath:indexPath];
}

- (void)mocoa_collectionView:(UICollectionView *)collectionView didEndDisplayingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel collectionView:collectionView didEndDisplayingRow:self atIndexPath:indexPath];
}

@end
