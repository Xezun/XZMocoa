//
//  Example31Group110FooterView.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example31Group110FooterView.h"

@interface Example31Group110FooterView ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;
@end

@implementation Example31Group110FooterView

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/110/footer:/").viewClass = self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.systemIndigoColor;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:_textLabel];
        
        _detailTextLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_detailTextLabel];
        
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_textLabel]-20-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_detailTextLabel]-20-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_detailTextLabel)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textLabel attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:-10.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_detailTextLabel attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:+10.0]];
    }
    return self;
}

- (void)viewModelDidChange {
    self.textLabel.text = @"Footer视图";
    self.detailTextLabel.text = self.viewModel.model;
}

@end
