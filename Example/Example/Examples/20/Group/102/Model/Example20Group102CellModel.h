//
//  Example20Group102CellModel.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group102CellModel : NSObject <XZMocoaTableCellModel>
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSURL *image;
@end

NS_ASSUME_NONNULL_END
