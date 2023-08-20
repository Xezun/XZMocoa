//
//  Example30Group109CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group109CellViewModel.h"
#import "Example30Group109CellModel.h"

@implementation Example30Group109CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/109/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    Example30Group109CellModel *model = self.model;
    self.text = model.text;
}

@end
