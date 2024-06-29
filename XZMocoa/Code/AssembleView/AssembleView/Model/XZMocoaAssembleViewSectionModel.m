//
//  XZMocoaAssembleViewSectionModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/8/21.
//

#import "XZMocoaAssembleViewSectionModel.h"

@interface NSObject (XZMocoaAssembleViewSectionModel) <XZMocoaAssembleViewSectionModel>
@end

@implementation NSObject (XZMocoaAssembleViewSectionModel)

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


@interface NSArray (XZMocoaAssembleViewSectionModel)
@end

@implementation NSArray (XZMocoaAssembleViewSectionModel)

- (NSInteger)numberOfCellModels {
    return self.count;
}

- (id)modelForCellAtIndex:(NSInteger)index {
    return [self objectAtIndex:index];
}

@end
