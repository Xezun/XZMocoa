//
//  Example31Group106CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group106CellViewModel.h"
#import "Example31Group106CellModel.h"

@implementation Example31Group106CellViewModel

- (void)prepare {
    [super prepare];
    self.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 80.0);
    
    Example31Group106CellModel *model = self.model;
    self.text = model.text;
}

@end
