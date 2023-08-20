//
//  Example30Group101Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group101Cell.h"
#import "Example30Group101CellViewModel.h"

@implementation Example30Group101Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)viewModelDidChange {
    Example30Group101CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = viewModel.text;
}

@end
