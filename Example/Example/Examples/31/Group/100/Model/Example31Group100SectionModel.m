//
//  Example31Group100SectionModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example31Group100SectionModel.h"

@implementation Example31Group100SectionModel 

+ (void)load {
    XZModule(@"https://mocoa.xezun.com/examples/31/collection/100/").modelClass = self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[Example31Group100CellModel alloc] init];
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
