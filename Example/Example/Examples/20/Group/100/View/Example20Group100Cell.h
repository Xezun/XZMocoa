//
//  Example20Group100Cell.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group100Cell : UITableViewCell <XZMocoaTableCell>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@end

NS_ASSUME_NONNULL_END
