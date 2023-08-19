//
//  Example20Group101CellModel.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <XZMocoa/XZMocoa.h>
@import YYModel;

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group101CellModel : XZMocoaTableViewCellModel <YYModel>
@property (nonatomic, copy) NSString *nid;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<NSString *> *images;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *comments;
@end

NS_ASSUME_NONNULL_END
