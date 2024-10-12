//
//  Example20Model.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <XZMocoa/XZMocoa.h>
@import XZJSON;

NS_ASSUME_NONNULL_BEGIN

@interface Example20Model : NSObject <XZMocoaModel>

@property (nonatomic) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSArray *data;

@end

NS_ASSUME_NONNULL_END
