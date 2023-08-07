//
//  XZMocoaTargetAction.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaTargetAction : NSObject
@property (nonatomic, weak, readonly) id target;
@property (nonatomic, readonly) SEL action;
- (instancetype)initWithTarget:(id)target action:(nullable SEL)selector;
- (void)sendActionWithObject:(id)object;
@end

NS_ASSUME_NONNULL_END
