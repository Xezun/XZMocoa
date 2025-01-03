//
//  Example30Group103CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group103CellViewModel.h"
#import "Example30Group103CellModel.h"

@implementation Example30Group103CellViewModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/103/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 80.0;
    
    Example30Group103CellModel *model = self.model;
    self.text = model.text;
}

@end
