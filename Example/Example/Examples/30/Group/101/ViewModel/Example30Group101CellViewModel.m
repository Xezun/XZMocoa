//
//  Example30Group101CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group101CellViewModel.h"
#import "Example30Group101CellModel.h"

@implementation Example30Group101CellViewModel

- (void)prepare {
    [super prepare];
    
    Example30Group101CellModel *model = self.model;
    self.text = model.text;
}

@end
