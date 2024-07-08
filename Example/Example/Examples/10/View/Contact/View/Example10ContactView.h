//
//  Example10ContactView.h
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaView.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example10ContactView : UIView <XZMocoaView>

@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

+ (Example10ContactView *)contactView;

@end

NS_ASSUME_NONNULL_END
