//
//  Example20ViewModel.h
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example20ViewModel : XZMocoaViewModel

@property (nonatomic, strong) XZMocoaTableViewModel *tableViewModel;

@property (nonatomic, setter=setHeaderRefreshing:) BOOL isHeaderRefreshing XZ_MOCOA_KEY("isHeaderRefreshing");
@property (nonatomic, setter=setFooterRefreshing:) BOOL isFooterRefreshing XZ_MOCOA_KEY("isFooterRefreshing");

- (void)headerDidBeginRefreshing;
- (void)footerDidBeginRefreshing;

@end

NS_ASSUME_NONNULL_END
