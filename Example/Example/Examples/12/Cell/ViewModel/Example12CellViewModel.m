//
//  Example12CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example12CellViewModel.h"
#import "Example12CellModel.h"

@implementation Example12CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/12/table/").section.cell.viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 44.0;
    
    Example12CellModel *data = self.model;
    self.name = [NSString stringWithFormat:@"%@ %@", data.firstName, data.lastName];
}

@end
