//
//  XZMocoaKeyedTargetActions.m
//  XZMocoa
//
//  Created by Xezun on 2023/8/8.
//

#import "XZMocoaKeyedTargetActions.h"
#import "XZMocoaTargetAction.h"

@implementation XZMocoaKeyedTargetActions {
    NSMutableDictionary<NSString *, NSMutableArray<XZMocoaTargetAction *> *> *_table;
}

- (instancetype)initWithOwner:(XZMocoaViewModel *)owner {
    self = [super init];
    if (self) {
        _owner = owner;
        _table = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action forKeyEvents:(NSString *)keyEvents {
    NSMutableArray<XZMocoaTargetAction *> *targetActions = _table[keyEvents];
    if (targetActions == nil) {
        targetActions = [NSMutableArray array];
        _table[keyEvents] = targetActions;
    }
    XZMocoaTargetAction *targetAction = [[XZMocoaTargetAction alloc] initWithTarget:target action:action];
    [targetActions addObject:targetAction];
    // 绑定时，立即发送事件
    [targetAction sendActionWithObject:self.owner];
}

- (void)removeTarget:(id)target action:(SEL)action forKeyEvents:(nullable NSString *)keyEvents {
    if (target == nil) {
        if (action == nil) {
            if (keyEvents == nil) {
                [_table removeAllObjects];
            } else { // keyEvents
                [_table[keyEvents] removeAllObjects];
            }
        } else {
            if (keyEvents == nil) { // action
                [_table enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableArray<XZMocoaTargetAction *> *targetActions, BOOL *stop) {
                    [targetActions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XZMocoaTargetAction *obj, NSUInteger idx, BOOL *stop) {
                        id const target1 = obj.target;
                        if (target1 == nil || obj.action == action) {
                            [targetActions removeObjectAtIndex:idx];
                        }
                    }];
                }];
            } else { // action & keyEvents
                NSMutableArray<XZMocoaTargetAction *> *targetActions = _table[keyEvents];
                [targetActions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XZMocoaTargetAction *obj, NSUInteger idx, BOOL *stop) {
                    id const target1 = obj.target;
                    if (target1 == nil || obj.action == action) {
                        [targetActions removeObjectAtIndex:idx];
                    }
                }];
            }
        }
    } else {
        if (action == NULL) {
            if (keyEvents == nil) { // target
                [_table enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableArray<XZMocoaTargetAction *> *targetActions, BOOL *stop) {
                    [targetActions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XZMocoaTargetAction *obj, NSUInteger idx, BOOL *stop) {
                        id const target1 = obj.target;
                        if (target1 == nil || target1 == target) {
                            [targetActions removeObjectAtIndex:idx];
                        }
                    }];
                }];
            } else { // target & keyEvents
                NSMutableArray<XZMocoaTargetAction *> *targetActions = _table[keyEvents];
                [targetActions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XZMocoaTargetAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    id const target1 = obj.target;
                    if (target1 == nil || target1 == target) {
                        [targetActions removeObjectAtIndex:idx];
                    }
                }];
            }
        } else {
            if (keyEvents == nil) { // target & action
                [_table enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableArray<XZMocoaTargetAction *> *targetActions, BOOL *stop) {
                    [targetActions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XZMocoaTargetAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        id const target1 = obj.target;
                        if (target1 == nil || (target1 == target && obj.action == action)) {
                            [targetActions removeObjectAtIndex:idx];
                        }
                    }];
                }];
            } else { // target & action & keyEvents
                NSMutableArray<XZMocoaTargetAction *> *targetActions = _table[keyEvents];
                [targetActions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XZMocoaTargetAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    id const target1 = obj.target;
                    if (target1 == nil || (target1 == target && obj.action == action)) {
                        [targetActions removeObjectAtIndex:idx];
                    }
                }];
            }
        }
    }
}

- (void)sendActionsForKeyEvents:(NSString *)keyEvents {
    NSMutableArray<XZMocoaTargetAction *> *targetActions = _table[keyEvents];
    [targetActions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XZMocoaTargetAction *targetAction, NSUInteger idx, BOOL *stop) {
        id  const target = targetAction.target;
        if (target == nil) {
            [targetActions removeObjectAtIndex:idx]; // 删除 target 已销毁的监听
        } else {
            [targetAction sendActionWithObject:self.owner];
        }
    }];
}

@end
