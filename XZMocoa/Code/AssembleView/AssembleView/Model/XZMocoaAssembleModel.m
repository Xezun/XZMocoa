//
//  XZMocoaAssembleModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/3/28.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaAssembleModel.h"

@interface NSObject (XZMocoaAssembleModel) <XZMocoaAssembleModel>
@end

@implementation NSObject (XZMocoaAssembleModel)

- (NSInteger)numberOfSectionModels {
    return 1;
}

- (id<XZMocoaAssembleViewSectionModel>)modelForSectionAtIndex:(NSInteger)index {
    return (id)self;
}

@end


@interface NSArray (XZMocoaAssembleModel)
@end

@implementation NSArray (XZMocoaAssembleModel)

- (NSInteger)numberOfSectionModels {
    return self.count;
}

- (id<XZMocoaAssembleViewSectionModel>)modelForSectionAtIndex:(NSInteger)index {
    return [self objectAtIndex:index];
}

@end
