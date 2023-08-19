//
//  XZMocoaCollectionViewSectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityViewSectionViewModel.h>
#import <XZMocoa/XZMocoaCollectionViewCellViewModel.h>
#import <XZMocoa/XZMocoaCollectionViewSupplementaryViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionViewSectionViewModel : XZMocoaListityViewSectionViewModel<XZMocoaCollectionViewCellViewModel *>
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
- (__kindof XZMocoaCollectionViewSupplementaryViewModel *)viewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
