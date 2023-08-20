//
//  Example30Group108CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group108CellViewModel.h"
#import "Example30Group108CellModel.h"

@implementation Example30Group108CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/108/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    Example30Group108CellModel *model = self.model;
    self.text = model.text;
}

@end
