//
//  Example31Group103CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group103CellViewModel.h"
#import "Example31Group103CellModel.h"

@implementation Example31Group103CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/103/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 80.0);
    
    Example31Group103CellModel *model = self.model;
    self.text = model.text;
}

@end
