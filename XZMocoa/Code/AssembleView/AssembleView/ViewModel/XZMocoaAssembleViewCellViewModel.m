//
//  XZMocoaAssembleViewCellViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/1/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaAssembleViewCellViewModel.h"
#import "XZMocoaDefines.h"
#import "XZMocoaModule.h"
#import "XZMocoaAssembleViewSectionViewModel.h"

@interface XZMocoaAssembleViewCellViewModel ()
@end

@implementation XZMocoaAssembleViewCellViewModel

- (instancetype)initWithModel:(NSObject<NSObject> *)model {
    self = [super initWithModel:model];
    if (self) {
        _frame      = CGRectZero;
        _identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaKindCell, XZMocoaNameNone);
    }
    return self;
}

@end




