//
//  Example30Group107CellModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group107CellModel.h"

@implementation Example30Group107CellModel
+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/107/:/").modelClass = self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass(self.class), self, self.text];
}
@end
