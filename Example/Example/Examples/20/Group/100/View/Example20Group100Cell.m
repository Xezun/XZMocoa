//
//  Example20Group100Cell.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group100Cell.h"
#import "Example20Group100CellViewModel.h"
@import SDWebImage;

@implementation Example20Group100Cell

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/100/:/").viewNibClass = self;
}

@synthesize imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)viewModelDidChange {
    Example20Group100CellViewModel *viewModel = self.viewModel;
    self.titleLabel.text = viewModel.title;
    [self.imageView sd_setImageWithURL:viewModel.image];
    self.detailsLabel.text = viewModel.details;
}

@end
