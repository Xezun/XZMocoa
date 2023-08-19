//
//  Example22TextModel.h
//  Example
//
//  Created by Xezun on 2023/8/9.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example22TextModel : XZMocoaCollectionViewCellModel
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, copy) NSString *phone;

+ (Example22TextModel *)contactWithFirstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone;
+ (Example22TextModel *)contactForIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
