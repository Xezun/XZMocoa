//
//  Example10RootView.h
//  Example
//
//  Created by Xezun on 2023/7/25.
//

#import <UIKit/UIKit.h>
#import "Example10ContactView.h"
#import "Example10ContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example10RootView : UIView
@property (nonatomic, strong) Example10ContactView *contactView;
@property (nonatomic, strong) Example10ContentView *contentView;
@end

NS_ASSUME_NONNULL_END
