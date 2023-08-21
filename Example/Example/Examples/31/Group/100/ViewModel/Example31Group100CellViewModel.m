//
//  Example31Group100CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group100CellViewModel.h"
#import "Example31Group100CellModel.h"

@implementation Example31Group100CellViewModel

- (void)prepare {
    [super prepare];
    
    Example31Group100CellModel *model = self.model;
    self.text = model.text;
}

@end
