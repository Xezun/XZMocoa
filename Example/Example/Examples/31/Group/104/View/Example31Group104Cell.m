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
@property (nonatomic, strong) UILabel *detailTextLabel;
@end

@implementation Example31Group104Cell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
    Example31Group104CellViewModel *viewModel = self.viewModel;
    self.textLabel.text = @"Cell视图";
    self.detailTextLabel.text = viewModel.text;
}

@end
