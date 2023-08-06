//
//  XZMocoaTableSectionHeaderViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaTableSectionHeaderViewModel.h"

@implementation XZMocoaTableSectionHeaderViewModel
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
    [self emit:XZMocoaEmitNone value:nil];
}
@end
