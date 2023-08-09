//
//  XZMocoaCollectionCellViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaCollectionCellViewModel.h"

@implementation XZMocoaCollectionCellViewModel

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    if (CGSizeEqualToSize(frame.size, size)) {
        return;
    }
    frame.size = size;
    self.frame = frame;
    [self sizeDidChange];
}

- (void)sizeDidChange {
    [self emit:XZMocoaEmitNone value:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
