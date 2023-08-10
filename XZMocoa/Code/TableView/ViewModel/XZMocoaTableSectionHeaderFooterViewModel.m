//
//  XZMocoaTableSectionHeaderFooterViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import "XZMocoaTableSectionHeaderFooterViewModel.h"

@implementation XZMocoaTableSectionHeaderFooterViewModel

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    if (self.frame.size.height == height) {
        return;
    }
    frame.size.height = height;
    self.frame = frame;
    [self heightDidChange];
}

- (void)heightDidChange {
    [self emit:XZMocoaEmitUpdate value:nil];
}

@end
