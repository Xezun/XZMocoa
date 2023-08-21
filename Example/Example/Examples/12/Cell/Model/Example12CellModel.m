//
//  Example12CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example12CellModel.h"

@implementation Example12CellModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/12/table/").section.cell.modelClass = self;
}

@end
