//
//  Example22ViewModel.h
//  Example
//
//  Created by Xezun on 2023/8/9.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example22ViewModel : XZMocoaViewModel

@property (nonatomic, strong, readonly) XZMocoaCollectionViewModel *collectionViewModel;
@property (nonatomic, copy, readonly) NSArray<NSString *> *testActions;
- (void)performTestActionAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
