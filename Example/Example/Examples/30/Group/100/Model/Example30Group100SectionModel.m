//
//  Example30Group100SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30Group100SectionModel.h"

@implementation Example30Group100SectionModel 

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/100/").modelClass = self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[Example30Group100CellModel alloc] init];
    }
    return self;
}

- (XZMocoaName)mocoaName {
    return @"100";
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return _model;
}

@end
