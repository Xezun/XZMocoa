//
//  Example30Group109Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group109Cell.h"
#import "Example30Group109CellViewModel.h"

@implementation Example30Group109Cell

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/109/:/").viewClass = self;
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
    Example30Group109CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = @"Cell视图";
    self.detailTextLabel.text = viewModel.text;
}

@end
