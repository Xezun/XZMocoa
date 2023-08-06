//
//  Example10Model.h
//  Example
//
//  Created by Xezun on 2023/7/25.
//

#import <Foundation/Foundation.h>
#import "Example10Contact.h"

NS_ASSUME_NONNULL_BEGIN

@class Example10ContentModel;

@interface Example10Model : NSObject
@property (nonatomic, strong) Example10Contact *contact;
@property (nonatomic, strong) Example10ContentModel *content;
@end

@interface Example10ContentModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@end

NS_ASSUME_NONNULL_END
