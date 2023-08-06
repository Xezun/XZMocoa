//
//  XZMocoaListityCellViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/1/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaListityCellViewModel.h"
#import "XZMocoaDefines.h"
#import "XZMocoaModule.h"
#import "XZMocoaListitySectionViewModel.h"

@interface XZMocoaListityCellViewModel ()
@end

@implementation XZMocoaListityCellViewModel

- (instancetype)initWithModel:(NSObject<NSObject> *)model {
    self = [super initWithModel:model];
    if (self) {
        _frame      = CGRectZero;
        _identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaNameNone);
    }
    return self;
}

@end




