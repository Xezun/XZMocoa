//
//  Example20Group101SectionModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group101SectionModel.h"
#import "Example20Group101CellModel.h"

@implementation Example20Group101SectionModel

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/101/").modelClass = self;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
        @"items": [Example20Group101CellModel class]
    };
}

- (XZMocoaName)mocoaName {
    return @"101";
}

- (NSInteger)numberOfCellModels {
    return self.items.count;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return [self.items objectAtIndex:index];
}

@end
