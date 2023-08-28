//
//  Example30Group102CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group102CellViewModel.h"
#import "Example30Group102CellModel.h"

@implementation Example30Group102CellViewModel

- (void)prepare {
    [super prepare];
    self.height = 80.0;
    
    Example30Group102CellModel *model = self.model;
    self.text = model.text;
}

@end
