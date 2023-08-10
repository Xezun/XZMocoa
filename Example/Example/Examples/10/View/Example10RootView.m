//
//  Example10RootView.m
//  Example
//
//  Created by Xezun on 2023/7/25.
//

#import "Example10RootView.h"

@implementation Example10RootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _contactView = [Example10ContactView contactView];
        [self addSubview:_contactView];
        _contentView = [[Example10ContentView alloc] init];
        [self addSubview:_contentView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect const bounds = UIEdgeInsetsInsetRect(self.bounds, self.safeAreaInsets);
    _contactView.frame = bounds;
    [_contactView sizeToFit];
    
    _contentView.frame = bounds;
    [_contentView sizeToFit];
    
    CGRect frame = _contentView.frame;
    frame.origin.y = CGRectGetMaxY(_contactView.frame) + 20;
    _contentView.frame = frame;
}

@end
