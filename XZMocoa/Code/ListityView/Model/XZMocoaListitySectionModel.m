//
//  XZMocoaListitySectionModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/8/21.
//

#import "XZMocoaListitySectionModel.h"

@interface NSObject (XZMocoaListitySectionModel) <XZMocoaListitySectionModel>
@end

@implementation NSObject (XZMocoaListitySectionModel)

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return self;
}

- (NSArray<XZMocoaKind> *)supplementaryKinds {
    return @[XZMocoaKindHeader, XZMocoaKindFooter];
}

- (NSInteger)numberOfModelsForSupplementaryKind:(XZMocoaKind)kind {
    return 1;
}

- (id)modelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    return nil;
}

@end


@interface NSArray (XZMocoaListitySectionModel)
@end

@implementation NSArray (XZMocoaListitySectionModel)

- (NSInteger)numberOfCellModels {
    return self.count;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return [self objectAtIndex:index];
}

@end
