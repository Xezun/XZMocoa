//
//  Example30Group106Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group106Cell.h"
#import "Example30Group106CellViewModel.h"

@implementation Example30Group106Cell

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/106/:/").viewClass = self;
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
    Example30Group106CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = viewModel.text;
}

@end
