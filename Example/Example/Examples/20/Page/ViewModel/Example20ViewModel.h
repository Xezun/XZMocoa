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

- (void)headerRefreshAction:(void (^)(BOOL hasData))completion;
- (void)footerRefreshAction:(void (^)(BOOL hasData))completion;

@end

NS_ASSUME_NONNULL_END
