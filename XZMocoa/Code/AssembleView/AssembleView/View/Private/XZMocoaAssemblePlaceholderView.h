//
//  XZMocoaAssemblePlaceholderView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/28.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaViewModel.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
@interface XZMocoaAssemblePlaceholderViewModel : XZMocoaViewModel
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *detail;
@end

@interface XZMocoaAssemblePlaceholderView : UIView <XZMocoaView>
@end
#endif

NS_ASSUME_NONNULL_END
