//
//  Example30Group110CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group110CellModel.h"

@implementation Example30Group110CellModel
+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/110/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
