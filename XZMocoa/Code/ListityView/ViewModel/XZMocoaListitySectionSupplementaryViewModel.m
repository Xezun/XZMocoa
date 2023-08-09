//
//  XZMocoaListitySectionSupplementaryViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import "XZMocoaListitySectionSupplementaryViewModel.h"

@implementation XZMocoaListitySectionSupplementaryViewModel

- (instancetype)initWithModel:(id<NSObject>)model {
    self = [super initWithModel:model];
    if (self) {
        _frame      = CGRectZero;
        _identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaKindNone, XZMocoaNameNone);
    }
    return self;
}

@end
