//
//  Example30Group110FooterView.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example30Group110FooterView.h"

@implementation Example30Group110FooterView {
    UILabel *_textLabel;
    UILabel *_detailTextLabel;
}

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/110/footer:/").viewClass = self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.systemIndigoColor;
        self.backgroundView = view;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textLabel];
        
        _detailTextLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_detailTextLabel];
        
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_textLabel]-20-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_detailTextLabel]-20-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_detailTextLabel)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_textLabel attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:-10.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_detailTextLabel attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:+10.0]];
    }
    return self;
}

- (void)viewModelDidChange {
    _textLabel.text = @"Footer视图";
    _detailTextLabel.text = self.viewModel.model;
}

@end
