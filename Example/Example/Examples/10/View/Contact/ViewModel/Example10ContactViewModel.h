//
//  Example10ContactViewModel.h
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example10ContactViewModel : XZMocoaViewModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL    *photo;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@end

NS_ASSUME_NONNULL_END
