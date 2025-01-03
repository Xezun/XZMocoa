//
//  Example22TextCell.m
//  Example
//
//  Created by Xezun on 2023/8/9.
//

#import "Example22TextCell.h"

@implementation Example22TextCell
@dynamic viewModel;

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/22/").section.cell.viewNibClass = self;
}

- (void)viewModelWillChange {
    [self.viewModel removeTarget:self action:nil forKeyEvents:nil];
}

- (void)viewModelDidChange {
    [self.viewModel addTarget:self action:@selector(nameDidChange:) forKeyEvents:@"name"];
    [self.viewModel addTarget:self action:@selector(phoneDidChange:) forKeyEvents:@"phone"];
}

- (void)nameDidChange:(Example22TextViewModel *)viewModel {
    XZLog(@"old: %@, new: %@", self.textLabel.text, viewModel.name);
    self.textLabel.text = viewModel.name;
}

- (void)phoneDidChange:(Example22TextViewModel *)viewModel {
    XZLog(@"old: %@, new: %@", self.detailTextLabel.text, viewModel.phone);
    self.detailTextLabel.text = viewModel.phone;
}

@end
