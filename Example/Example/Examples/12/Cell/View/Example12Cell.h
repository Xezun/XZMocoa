//
//  Example12Cell.h
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import <UIKit/UIKit.h>
@import XZMocoa;

NS_ASSUME_NONNULL_BEGIN

@interface Example12Cell : UITableViewCell <XZMocoaTableViewCell>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

NS_ASSUME_NONNULL_END
