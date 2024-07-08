//
//  Example21ContactBookTestViewController.h
//  Example
//
//  Created by Xezun on 2021/7/12.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Example21ContactBookTestViewController;
@protocol Example21ContactBookTestViewControllerDelegate <NSObject>
- (void)testVC:(Example21ContactBookTestViewController *)textVC didSelectTestActionAtIndex:(NSUInteger)index;
@end

@interface Example21ContactBookTestViewController : UITableViewController

@property (nonatomic, weak) id<Example21ContactBookTestViewControllerDelegate> delegate;

- (instancetype)initWithTestActions:(NSArray<NSString *> *)testActions;

@end

NS_ASSUME_NONNULL_END
