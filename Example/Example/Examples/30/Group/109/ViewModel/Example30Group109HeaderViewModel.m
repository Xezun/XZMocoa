//
//  Example30Group109HeaderViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example30Group109HeaderViewModel.h"

@implementation Example30Group109HeaderViewModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/109/header:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 80.0;
}

@end
