//
//  Example20Group102SectionModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group102SectionModel.h"
#import "Example20Group102CellModel.h"

@implementation Example20Group102SectionModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20/list/102/").modelClass = self;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
        @"items": [Example20Group102CellModel class]
    };
}

- (XZMocoaName)mocoaName {
    return @"102";
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return self.items;
}

@end
