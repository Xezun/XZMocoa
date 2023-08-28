//
//  Example30Group108Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group108Cell.h"
#import "Example30Group108CellViewModel.h"

@implementation Example30Group108Cell

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/108/:/").viewClass = self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
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
    Example30Group108CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = @"Cell视图";
    self.detailTextLabel.text = viewModel.text;
}

@end
