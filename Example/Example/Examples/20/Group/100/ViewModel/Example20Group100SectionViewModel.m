//
//  Example20Group100SectionViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group100SectionViewModel.h"

@implementation Example20Group100SectionViewModel

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/100/").viewModelClass = self;
}

@end
