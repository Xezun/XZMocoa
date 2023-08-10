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
    [self emit:XZMocoaEmitUpdate value:nil];
}

- (void)wasSelectedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)willBeDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didEndBeingDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
