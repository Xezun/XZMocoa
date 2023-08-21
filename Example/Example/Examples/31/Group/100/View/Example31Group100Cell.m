//
//  Example31Group100Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group100Cell.h"
#import "Example31Group100CellViewModel.h"

@interface Example31Group100Cell ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation Example31Group100Cell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)viewModelDidChange {
    Example31Group100CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = viewModel.text;
}

@end
