//
//  Example20Group101CellModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group101CellModel.h"

@implementation Example20Group101CellModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/20/table/101/:/").modelClass = self;
}


- (BOOL)isEqual:(Example20Group101CellModel *)object {
    if (object == self) return YES;
    if (![object isKindOfClass:[Example20Group101CellModel class]]) return NO;
    return [self.nid isEqualToString:object.nid];
}

@end
