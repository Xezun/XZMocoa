//
//  Example20Group101EditorViewModel.h
//  Example
//
//  Created by Xezun on 2023/7/30.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group101EditorViewModel : XZMocoaViewModel

@property (nonatomic, readonly) NSArray *images;

- (void)moveImageAtIndex:(NSInteger)index toIndex:(NSInteger)newIndex;
- (void)submit;

@end

NS_ASSUME_NONNULL_END
