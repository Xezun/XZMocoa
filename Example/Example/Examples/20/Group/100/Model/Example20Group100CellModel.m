//
//  Example20Group100CellModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group100CellModel.h"

@implementation Example20Group100CellModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20/list/100/:/").modelClass = self;
}

- (BOOL)isEqual:(Example20Group100CellModel *)object {
    if (object == self) return YES;
    if (![object isKindOfClass:[Example20Group100CellModel class]]) return NO;
    return [self.nid isEqualToString:object.nid];
}

@end
