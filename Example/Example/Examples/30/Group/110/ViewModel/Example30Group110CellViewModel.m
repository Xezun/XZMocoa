//
//  Example30Group110CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group110CellViewModel.h"
#import "Example30Group110CellModel.h"

@implementation Example30Group110CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/110/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.height = 80.0;
    
    Example30Group110CellModel *model = self.model;
    self.text = model.text;
}

@end
