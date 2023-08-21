//
//  Example31Group104Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group104Cell.h"
#import "Example31Group104CellViewModel.h"

@interface Example31Group104Cell ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation Example31Group104Cell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)viewModelDidChange {
    Example31Group104CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = viewModel.text;
}

@end
