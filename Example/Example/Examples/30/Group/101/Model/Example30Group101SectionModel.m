//
//  Example30Group101SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group101SectionModel.h"

@implementation Example30Group101SectionModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/101/").modelClass = self;
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
