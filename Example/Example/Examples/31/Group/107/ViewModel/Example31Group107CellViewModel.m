//
//  Example31Group107CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group107CellViewModel.h"
#import "Example31Group107CellModel.h"

@implementation Example31Group107CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/107/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    self.size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 80.0);
    
    Example31Group107CellModel *model = self.model;
    self.text = model.text;
}

@end
