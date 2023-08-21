//
//  Example31Group101SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group101SectionModel.h"

@implementation Example31Group101SectionModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/31/collection/101/").modelClass = self;
}

- (XZMocoaName)mocoaName {
    return @"101";
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return _model;
}

@end
