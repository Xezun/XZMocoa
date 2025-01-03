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
    XZModule(@"https://mocoa.xezun.com/examples/21/").section.cell.viewNibClass = self;
}

- (void)viewModelWillChange {
    [self.viewModel removeTarget:self action:nil forKeyEvents:nil];
}

- (void)viewModelDidChange {
    [self.viewModel addTarget:self action:@selector(nameDidChange:) forKeyEvents:@"name"];
    [self.viewModel addTarget:self action:@selector(phoneDidChange:) forKeyEvents:@"phone"];
}

- (void)nameDidChange:(Example21ContactCellViewModel *)viewModel {
    XZLog(@"old: %@, new: %@", self.textLabel.text, viewModel.name);
    self.textLabel.text = viewModel.name;
}

- (void)phoneDidChange:(Example21ContactCellViewModel *)viewModel {
    XZLog(@"old: %@, new: %@", self.detailTextLabel.text, viewModel.phone);
    self.detailTextLabel.text = viewModel.phone;
}

@end
