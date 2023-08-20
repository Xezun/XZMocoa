//
//  Example30ViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30ViewModel.h"

@implementation Example30ViewModel

- (void)prepare {
    [super prepare];
    
    _tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:@[
        @0, @1, @2, @3
    ]];
    [self addSubViewModel:_tableViewModel];
}

@end
