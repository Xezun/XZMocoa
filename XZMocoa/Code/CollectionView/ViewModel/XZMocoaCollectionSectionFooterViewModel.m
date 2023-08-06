//
//  XZMocoaCollectionSectionFooterViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaCollectionSectionFooterViewModel.h"

@implementation XZMocoaCollectionSectionFooterViewModel
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
@end
