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

- (void)collectonView:(UICollectionView *)collectonView didSelectRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectonView:(UICollectionView *)collectonView willDisplayRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectonView:(UICollectionView *)collectonView didEndDisplayingRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
