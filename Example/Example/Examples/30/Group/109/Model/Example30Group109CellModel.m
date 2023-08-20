//
//  Example30Group109CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group109CellModel.h"

@implementation Example30Group109CellModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/109/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
