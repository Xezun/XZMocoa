//
//  Example20Group100CellViewModel.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group100CellViewModel : XZMocoaTableCellViewModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSURL *image;

@end

NS_ASSUME_NONNULL_END
