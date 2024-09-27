//
//  Example30Group110SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group110SectionModel.h"

@implementation Example30Group110SectionModel

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/110/").modelClass = self;
}

- (XZMocoaName)mocoaName {
    return @"110";
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
