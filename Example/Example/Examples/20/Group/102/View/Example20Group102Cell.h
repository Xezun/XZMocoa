//
//  Example20Group102Cell.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoa.h>
@import XZPageView;
@import XZPageControl;

@class Example20Group102CellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group102Cell : UITableViewCell <XZMocoaTableCell>
@property (weak, nonatomic) IBOutlet XZPageView *pageView;
@property (weak, nonatomic) IBOutlet XZPageControl *pageControl;
@end

NS_ASSUME_NONNULL_END
