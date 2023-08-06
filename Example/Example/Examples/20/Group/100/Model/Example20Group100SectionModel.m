//
//  Example20Group100SectionModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group100SectionModel.h"
#import "Example20Group100CellModel.h"

@implementation Example20Group100SectionModel

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/100/").modelClass = self;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
        @"items": [Example20Group100CellModel class]
    };
}

- (XZMocoaName)mocoaName {
    return @"100";
}

- (NSInteger)numberOfCellModels {
    return self.items.count;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return [self.items objectAtIndex:index];
}

@end
