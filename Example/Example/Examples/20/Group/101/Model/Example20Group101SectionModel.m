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
    XZModule(@"https://mocoa.xezun.com/examples/20/table/101/").modelClass = self;
}

- (BOOL)isEqual:(Example20Group101SectionModel *)object {
    if (self == object) return YES;
    if (![object isKindOfClass:[Example20Group101SectionModel class]]) return NO;
    return [self.gid isEqual:object.gid];
}

+ (NSDictionary<NSString *,id> *)mappingJSONCodingClasses {
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
