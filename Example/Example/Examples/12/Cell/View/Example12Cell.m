//
//  Example12Cell.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example12Cell.h"
#import "Example12CellViewModel.h"

@implementation Example12Cell

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/12/table/").section.cell.viewNibClass = self;
}

- (void)viewModelDidChange {
    Example12CellViewModel *viewModel = self.viewModel;
    
    self.nameLabel.text = viewModel.name;
}

@end
