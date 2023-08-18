//
//  Example20Model.h
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import <XZMocoa/XZMocoa.h>
@import YYModel;

NS_ASSUME_NONNULL_BEGIN

@interface Example20Model : NSObject <XZMocoaModel, YYModel>

@property (nonatomic) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSArray *data;

@end

NS_ASSUME_NONNULL_END
