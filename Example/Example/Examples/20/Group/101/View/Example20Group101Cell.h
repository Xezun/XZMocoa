//
//  Example20Group101Cell.h
//  Example
//
//  Created by Xezun on 2023/7/24.
//

#import <UIKit/UIKit.h>
@import XZMocoa;

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group101Cell : UITableViewCell <XZMocoaTableCell>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end

NS_ASSUME_NONNULL_END
