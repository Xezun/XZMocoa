//
//  Example30Group103SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group103SectionModel.h"

@implementation Example30Group103SectionModel
+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/103/").modelClass = self;
}

- (XZMocoaName)mocoaName {
    return @"103";
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return _model;
}
@end
