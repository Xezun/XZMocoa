//
//  Example20Group102CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group102CellViewModel.h"
#import "Example20Group102CellModel.h"

@implementation Example20Group102CellViewModel
+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/102/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 156.0;
    
    NSArray<Example20Group102CellModel *> *models = self.model;
    NSMutableArray *array = [NSMutableArray array];
    for (Example20Group102CellModel *obj in models) {
        [array addObject:obj.image];
    }
    self.images = array;
}

@end
