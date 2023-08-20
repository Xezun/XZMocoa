//
//  Example30Group107CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group107CellViewModel.h"
#import "Example30Group107CellModel.h"

@implementation Example30Group107CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/107/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    Example30Group107CellModel *model = self.model;
    self.text = model.text;
}

@end
