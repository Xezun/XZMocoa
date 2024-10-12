//
//  XZMocoaCollectionViewSectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListViewSectionViewModel.h>
#import <XZMocoa/XZMocoaCollectionViewCellViewModel.h>
#import <XZMocoa/XZMocoaCollectionViewSupplementaryViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionViewSectionViewModel : XZMocoaListViewSectionViewModel<XZMocoaCollectionViewCellViewModel *>
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
- (__kindof XZMocoaCollectionViewSupplementaryViewModel *)viewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
