//
//  XZMocoaCollectionSectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityViewSectionViewModel.h>
#import <XZMocoa/XZMocoaCollectionCellViewModel.h>
#import <XZMocoa/XZMocoaCollectionSectionSupplementaryViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionSectionViewModel : XZMocoaListityViewSectionViewModel<XZMocoaCollectionCellViewModel *>
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
- (__kindof XZMocoaCollectionSectionSupplementaryViewModel *)viewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
