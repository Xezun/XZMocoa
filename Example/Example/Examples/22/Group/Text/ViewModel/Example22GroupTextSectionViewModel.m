//
//  Example22GroupTextSectionViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/10.
//

#import "Example22GroupTextSectionViewModel.h"

@implementation Example22GroupTextSectionViewModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/22/").section.viewModelClass = self;
}
- (void)prepare {
    [super prepare];
    
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.insets = UIEdgeInsetsMake(10, 10, 10, 10);
}
@end
