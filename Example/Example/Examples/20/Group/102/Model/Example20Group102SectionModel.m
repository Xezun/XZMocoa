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
    XZModule(@"https://mocoa.xezun.com/examples/20/table/102/").modelClass = self;
}

- (BOOL)isEqual:(Example20Group102SectionModel *)object {
    if (self == object) return YES;
    if (![object isKindOfClass:[Example20Group102SectionModel class]]) return NO;
    return [self.gid isEqual:object.gid];
}

+ (NSDictionary<NSString *,id> *)mappingJSONCodingClasses {
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
