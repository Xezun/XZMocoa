//
//  Example21Contact.h
//  Example
//
//  Created by Xezun on 2021/4/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example21Contact : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, copy) NSString *phone;

+ (Example21Contact *)contactWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone;
+ (Example21Contact *)contactForIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
