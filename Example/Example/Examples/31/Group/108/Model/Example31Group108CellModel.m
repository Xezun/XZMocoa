//
//  Example31Group108CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group108CellModel.h"

@implementation Example31Group108CellModel
+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/31/collection/108/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
