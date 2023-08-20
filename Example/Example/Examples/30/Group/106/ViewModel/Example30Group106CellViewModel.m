//
//  Example30Group106CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group106CellViewModel.h"
#import "Example30Group106CellModel.h"

@implementation Example30Group106CellViewModel

- (void)prepare {
    [super prepare];
    
    Example30Group106CellModel *model = self.model;
    self.text = model.text;
}

@end
