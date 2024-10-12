//
//  Example30Group110HeaderViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example30Group110HeaderViewModel.h"

@implementation Example30Group110HeaderViewModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/110/header:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 80.0;
}

@end
