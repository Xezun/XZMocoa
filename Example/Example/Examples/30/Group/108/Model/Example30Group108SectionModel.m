//
//  Example30Group108SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group108SectionModel.h"

@implementation Example30Group108SectionModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/108/").modelClass = self;
}

- (XZMocoaName)mocoaName {
    return @"108";
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return _model;
}

- (id)headerModel {
    return _title;
}

- (id)footerModel {
    return _notes;
}

@end
