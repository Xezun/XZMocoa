//
//  XZMocoaKeyedTargetActions.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XZMocoaViewModel;

@interface XZMocoaKeyedTargetActions : NSObject
@property (nonatomic, unsafe_unretained) XZMocoaViewModel *owner;
- (instancetype)initWithOwner:(XZMocoaViewModel *)owner;
- (void)addTarget:(id)target action:(nullable SEL)action forKeyEvents:(NSString *)keyEvents;
- (void)removeTarget:(id)target action:(SEL)action forKeyEvents:(nullable NSString *)key;
- (void)sendActionsForKeyEvents:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
