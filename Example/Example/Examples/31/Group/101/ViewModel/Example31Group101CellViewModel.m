//
//  Example31Group101CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group101CellViewModel.h"
#import "Example31Group101CellModel.h"

@implementation Example31Group101CellViewModel

- (void)prepare {
    [super prepare];
    
    Example31Group101CellModel *model = self.model;
    self.text = model.text;
}

@end
