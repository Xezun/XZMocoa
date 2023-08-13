//
//  Example20ViewModel.h
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, Example20State) {
    Example20StateDefault,
    Example20StateRefresh,
    Example20StateLoading,
};

@interface Example20ViewModel : XZMocoaViewModel

@property (nonatomic, strong) XZMocoaTableViewModel *tableViewModel;

@property (nonatomic) Example20State state XZ_MOCOA_KEY();
@property (nonatomic, setter=setHeaderRefreshing:) BOOL isHeaderRefreshing XZ_MOCOA_KEY();
@property (nonatomic, setter=setFooterRefreshing:) BOOL isFooterRefreshing XZ_MOCOA_KEY();

- (void)refreshingHeaderDidBeginAnimating;
- (void)refreshingFooterDidBeginAnimating;

@end

NS_ASSUME_NONNULL_END
