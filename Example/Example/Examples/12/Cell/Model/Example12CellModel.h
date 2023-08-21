//
//  Example12CellModel.h
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import <Foundation/Foundation.h>
@import XZMocoa;

NS_ASSUME_NONNULL_BEGIN

@interface Example12CellModel : NSObject <XZMocoaTableViewCellModel>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@end

NS_ASSUME_NONNULL_END
