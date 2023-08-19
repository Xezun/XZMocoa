//
//  XZMocoaTableSectionHeaderFooterViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import "XZMocoaTableSectionHeaderFooterViewModel.h"

@implementation XZMocoaTableSectionHeaderFooterViewModel

- (instancetype)initWithModel:(id)model {
    self = [super initWithModel:model];
    if (self) {
#if DEBUG
        [super setFrame:CGRectMake(0, 0, 0, 30)];
#else
        [super setFrame:CGRectMake(0, 0, 0, XZMocoaTableViewHeaderFooterHeight)];
#endif
    }
    return self;
}

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
}

@end
