//
//  Example11ViewModel.h
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class Example11ViewModel;

@interface Example11ViewModel : XZMocoaViewModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *photo;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
