//
//  Example31Group110CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group110CellViewModel.h"
#import "Example31Group110CellModel.h"

@implementation Example31Group110CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/110/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    Example31Group110CellModel *model = self.model;
    self.text = model.text;
}

@end
