//
//  Example30Group105CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group105CellViewModel.h"
#import "Example30Group105CellModel.h"

@implementation Example30Group105CellViewModel
+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/105/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.height = 80.0;
    
    Example30Group105CellModel *model = self.model;
    self.text = model.text;
}

@end
