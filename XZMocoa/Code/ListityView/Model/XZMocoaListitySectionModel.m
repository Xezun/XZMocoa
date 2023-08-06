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

- (id)headerModel {
    return nil;
}

- (id)footerModel {
    return nil;
}

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return self;
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
