//
//  Example20Model.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <XZMocoa/XZMocoa.h>
@import YYModel;

NS_ASSUME_NONNULL_BEGIN

@interface Example20Model : XZMocoaModel <YYModel>

@property (nonatomic, copy) NSArray *list;

@end

NS_ASSUME_NONNULL_END
