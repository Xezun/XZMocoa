//
//  Example30Group108CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group108CellModel.h"

@implementation Example30Group108CellModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/108/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
