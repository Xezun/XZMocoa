//
//  XZMocoaCollectionSectionSupplementaryViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import "XZMocoaCollectionSectionSupplementaryViewModel.h"

@implementation XZMocoaCollectionSectionSupplementaryViewModel
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
}

- (void)willBeDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didEndBeingDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
