//
//  XZMocoaListityViewSectionModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/8/21.
//

#import "XZMocoaListityViewSectionModel.h"

@interface NSObject (XZMocoaListityViewSectionModel) <XZMocoaListityViewSectionModel>
@end

@implementation NSObject (XZMocoaListityViewSectionModel)

- (NSInteger)numberOfCellModels {
    return 1;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return self;
}

- (NSInteger)numberOfModelsForSupplementaryKind:(XZMocoaKind)kind {
    return 1;
}

- (id)modelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    if (index == 0) {
        if ([kind isEqualToString:XZMocoaKindHeader]) {
            return self.headerModel;
        }
        if ([kind isEqualToString:XZMocoaKindFooter]) {
            return self.footerModel;
        }
    }
    return nil;
}

- (id)headerModel {
    return nil;
}

- (id)footerModel {
    return nil;
}

@end


@interface NSArray (XZMocoaListityViewSectionModel)
@end

@implementation NSArray (XZMocoaListityViewSectionModel)

- (NSInteger)numberOfCellModels {
    return self.count;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return [self objectAtIndex:index];
}

@end
