//
//  Example30Group104SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group104SectionModel.h"

@implementation Example30Group104SectionModel
+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/30/table/104/").modelClass = self;
}

- (XZMocoaName)mocoaName {
    return @"104";
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return _model;
}
@end
