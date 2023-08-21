//
//  Example31Group101Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group101Cell.h"
#import "Example31Group101CellViewModel.h"

@interface Example31Group101Cell ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation Example31Group101Cell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)viewModelDidChange {
    Example31Group101CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = viewModel.text;
}

@end
