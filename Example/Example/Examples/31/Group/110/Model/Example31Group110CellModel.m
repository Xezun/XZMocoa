//
//  Example31Group110CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group110CellModel.h"

@implementation Example31Group110CellModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/110/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
