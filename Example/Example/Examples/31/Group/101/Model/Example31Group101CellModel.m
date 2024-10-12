//
//  Example31Group101CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group101CellModel.h"

@implementation Example31Group101CellModel
+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/31/collection/101/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
