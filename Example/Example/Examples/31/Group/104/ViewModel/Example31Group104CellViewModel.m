//
//  Example31Group104CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group104CellViewModel.h"
#import "Example31Group104CellModel.h"

@implementation Example31Group104CellViewModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/31/collection/104/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 80.0);
    
    Example31Group104CellModel *model = self.model;
    self.text = model.text;
}

@end
