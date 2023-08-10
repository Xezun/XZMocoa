//
//  Example10ContentView.m
//  Example
//
//  Created by Xezun on 2023/7/25.
//

#import "Example10ContentView.h"

@implementation Example10ContentView {
    UILabel *_titleLabel;
    UILabel *_contentLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect bounds = self.bounds;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 20.0)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _titleLabel.textColor = UIColor.systemGrayColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30.0, bounds.size.width, 0)];
        _contentLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _contentLabel.textAlignment = NSTextAlignmentJustified;
        _contentLabel.textColor = UIColor.systemGrayColor;
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize contentSize = [_contentLabel sizeThatFits:size];
    return CGSizeMake(size.width, 30.0 + contentSize.height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect const bounds = self.bounds;
    _titleLabel.frame = CGRectMake(0, 0, bounds.size.width, 20.0);
    _contentLabel.frame = CGRectMake(0, 30, bounds.size.width, bounds.size.height - 30.0);
}

- (NSString *)title {
    return _titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (NSString *)content {
    return _contentLabel.text;
}

- (void)setContent:(NSString *)content {
    _contentLabel.text = content;
}

@end
