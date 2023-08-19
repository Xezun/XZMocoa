//
//  Example20Group102Header.m
//  Example
//
//  Created by Xezun on 2023/8/19.
//

#import "Example20Group102Header.h"

@implementation Example20Group102Header

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20/table/102/header:/").viewClass = self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColor.redColor;
    }
    return self;
}

@end
