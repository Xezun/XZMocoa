//
//  Example20Group102SectionViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group102SectionViewModel.h"

@implementation Example20Group102SectionViewModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20/list/102/").viewModelClass = self;
}
@end
