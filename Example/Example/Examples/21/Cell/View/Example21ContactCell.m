//
//  Example21ContactCell.m
//  Example
//
//  Created by Xezun on 2021/4/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactCell.h"

@implementation Example21ContactCell

@dynamic viewModel;

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/21/").section.cell.viewNibClass = self;
}

- (void)viewModelWillChange {
    [self.viewModel removeTarget:self action:nil forKeyEvents:nil];
}

- (void)viewModelDidChange {
    self.viewModel.bind(@"name", self, ^(Example21ContactCellViewModel *viewModel, Example21ContactCell *self) {
        self.textLabel.text = viewModel.name;
    });
    
    self.viewModel.bind(@"phone", self, ^(Example21ContactCellViewModel *viewModel, Example21ContactCell *self) {
        self.detailTextLabel.text = viewModel.phone;
    });
}

@end
