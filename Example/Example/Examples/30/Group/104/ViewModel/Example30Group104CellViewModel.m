//
//  Example30Group104CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group104CellViewModel.h"
#import "Example30Group104CellModel.h"

@implementation Example30Group104CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/104/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.height = 80.0;
    
    Example30Group104CellModel *model = self.model;
    self.text = model.text;
}

@end
