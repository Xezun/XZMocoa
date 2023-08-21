//
//  Example31Group109CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group109CellViewModel.h"
#import "Example31Group109CellModel.h"

@implementation Example31Group109CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/109/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    Example31Group109CellModel *model = self.model;
    self.text = model.text;
}

@end
