//
//  Example30Group105SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group105SectionModel.h"

@implementation Example30Group105SectionModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/105/").modelClass = self;
}

- (XZMocoaName)mocoaName {
    return @"105";
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return _model;
}

@end
