//
//  Example31Group105CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group105CellViewModel.h"
#import "Example31Group105CellModel.h"

@implementation Example31Group105CellViewModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/105/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 80.0);
    
    Example31Group105CellModel *model = self.model;
    self.text = model.text;
}

@end
