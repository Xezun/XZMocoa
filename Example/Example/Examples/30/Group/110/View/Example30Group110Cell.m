//
//  Example30Group110Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group110Cell.h"
#import "Example30Group110CellViewModel.h"

@implementation Example30Group110Cell

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/110/:/").viewClass = self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)viewModelDidChange {
    Example30Group110CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = viewModel.text;
}

@end
