//
//  Example22TextCell.h
//  Example
//
//  Created by Xezun on 2023/8/9.
//

#import <XZMocoa/XZMocoa.h>
#import "Example22TextViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example22TextCell : XZMocoaCollectionViewCell
@property (nonatomic, strong, nullable) Example22TextViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;
@end

NS_ASSUME_NONNULL_END
