//
//  XZMocoaListitySectionFooterViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/1/17.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaListitySectionFooterViewModel.h"
#import "XZMocoaDefines.h"
#import "XZMocoaListitySectionViewModel.h"

@implementation XZMocoaListitySectionFooterViewModel

- (instancetype)initWithModel:(id<NSObject>)model {
    self = [super initWithModel:model];
    if (self) {
        _frame      = CGRectZero;
        _identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaNameNone);
    }
    return self;
}

@end
