//
//  Example31Group108Cell.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group108Cell.h"
#import "Example31Group108CellViewModel.h"

@interface Example31Group108Cell ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation Example31Group108Cell

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/108/:/").viewClass = self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)viewModelDidChange {
    Example31Group108CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = viewModel.text;
}

@end
