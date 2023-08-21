//
//  Example31Group110FooterView.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example31Group110FooterView.h"

@interface Example31Group110FooterView ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation Example31Group110FooterView

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/110/footer:/").viewClass = self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.font = [UIFont systemFontOfSize:14.0];
        _textLabel.textColor = UIColor.lightGrayColor;
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.frame = UIEdgeInsetsInsetRect(self.bounds, self.layoutMargins);
}

- (void)viewModelDidChange {
    self.textLabel.text = self.viewModel.model;
}

@end
