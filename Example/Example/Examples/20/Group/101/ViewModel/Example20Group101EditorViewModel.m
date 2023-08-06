//
//  Example20Group101EditorViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/30.
//

#import "Example20Group101EditorViewModel.h"

@implementation Example20Group101EditorViewModel

- (instancetype)initWithModel:(NSArray *)model {
    return [super initWithModel:model.mutableCopy];
}

- (void)prepare {
    [super prepare];
}

- (NSArray *)images {
    return self.model;
}

- (void)moveImageAtIndex:(NSInteger)index toIndex:(NSInteger)newIndex {
    NSMutableArray *_images = self.model;
    id image = _images[index];
    [_images removeObjectAtIndex:index];
    [_images insertObject:image atIndex:newIndex];
}

- (void)submit {
    [self emit:XZMocoaEmitNone value:self.model];
}

@end
