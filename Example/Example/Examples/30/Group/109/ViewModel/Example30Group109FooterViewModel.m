//
//  Example30Group109FooterViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example30Group109FooterViewModel.h"

@implementation Example30Group109FooterViewModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/109/footer:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.height = 80.0;
}

@end
