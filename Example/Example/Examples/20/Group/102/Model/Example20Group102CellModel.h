//
//  Example20Group102CellModel.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group102CellModel : NSObject <XZMocoaTableViewCellModel>
@property (nonatomic, copy) NSString *nid;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSURL *image;
@end

NS_ASSUME_NONNULL_END
