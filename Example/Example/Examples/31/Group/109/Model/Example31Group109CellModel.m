//
//  Example31Group109CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group109CellModel.h"

@implementation Example31Group109CellModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/109/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
