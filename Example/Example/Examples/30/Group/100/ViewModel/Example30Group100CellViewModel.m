//
//  Example30Group100CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group100CellViewModel.h"
#import "Example30Group100CellModel.h"

@implementation Example30Group100CellViewModel

- (void)prepare {
    [super prepare];
    
    Example30Group100CellModel *model = self.model;
    self.text = model.text;
}

@end
