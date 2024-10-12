//
//  Example31Group109HeaderViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example31Group109HeaderViewModel.h"

@implementation Example31Group109HeaderViewModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/31/collection/109/header:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 80.0);
}

@end
