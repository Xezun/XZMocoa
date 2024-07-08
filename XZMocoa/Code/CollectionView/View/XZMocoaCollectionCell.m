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
    mocoa_copyMethod(cls, @selector(wasSelectedInCollectionView:atIndexPath:), @selector(mocoa_wasSelectedInCollectionView:atIndexPath:));
    mocoa_copyMethod(cls, @selector(willBeDisplayedInCollectionView:atIndexPath:), @selector(mocoa_willBeDisplayedInCollectionView:atIndexPath:));
    mocoa_copyMethod(cls, @selector(didEndBeingDisplayedInCollectionView:atIndexPath:), @selector(mocoa_didEndBeingDisplayedInCollectionView:atIndexPath:));
}

- (void)mocoa_wasSelectedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel wasSelectedInCollectionView:collectionView atIndexPath:indexPath];
}

- (void)mocoa_willBeDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel willBeDisplayedInCollectionView:collectionView atIndexPath:indexPath];
}

- (void)mocoa_didEndBeingDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel didEndBeingDisplayedInCollectionView:collectionView atIndexPath:indexPath];
}

@end
