//
//  Example31Group110HeaderViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example31Group110HeaderViewModel.h"

@implementation Example31Group110HeaderViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/110/header:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.size = CGSizeMake(375.0, 50.0);
}

@end
