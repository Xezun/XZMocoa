//
//  XZMocoaListitySectionHeaderViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/4/1.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaListitySectionHeaderViewModel.h"
#import "XZMocoaDefines.h"

@implementation XZMocoaListitySectionHeaderViewModel

- (instancetype)initWithModel:(id<NSObject>)model {
    self = [super initWithModel:model];
    if (self) {
        _frame      = CGRectZero;
        _identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaNameNone);
    }
    return self;
}

@end
