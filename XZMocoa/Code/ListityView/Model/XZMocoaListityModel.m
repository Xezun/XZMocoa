//
//  XZMocoaListityModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/3/28.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaListityModel.h"

@interface NSObject (XZMocoaListityModel) <XZMocoaListityModel>
@end

@implementation NSObject (XZMocoaListityModel)

- (NSInteger)numberOfSectionModels {
    return 1;
}

- (id<XZMocoaListityViewSectionModel>)modelForSectionAtIndex:(NSInteger)index {
    return (id)self;
}

@end


@interface NSArray (XZMocoaListityModel)
@end

@implementation NSArray (XZMocoaListityModel)

- (NSInteger)numberOfSectionModels {
    return self.count;
}

- (id<XZMocoaListityViewSectionModel>)modelForSectionAtIndex:(NSInteger)index {
    return [self objectAtIndex:index];
}

@end
