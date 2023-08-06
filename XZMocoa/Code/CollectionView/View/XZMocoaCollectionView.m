//
//  XZMocoaCollectionView.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/24.
//

#import "XZMocoaCollectionView.h"

@implementation XZMocoaCollectionView

- (void)registerModule:(XZMocoaModule *)module {
    UICollectionView * const collectionView = self.contentView;
    if (!module || !collectionView) {
        return;
    }
    { // 注册一个默认的 Cell
        NSString * const identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaNameNone);
        [collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:identifier];
    }
    
    [module enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName section, BOOL *stop) {
        if (![kind isEqualToString:XZMocoaKindSection]) {
            return; // 不是 section 的 module 不需要处理
        }

        [submodule enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName name, BOOL *stop) {
            if ([kind isEqualToString:XZMocoaKindCell]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forCellWithReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forCellWithReuseIdentifier:identifier];
                }
            } else if ([kind isEqualToString:XZMocoaKindHeader]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
                }
            } else if ([kind isEqualToString:XZMocoaKindFooter]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, name);
                if (submodule.viewNibName != Nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
                }
            }
        }];
    }];
}

@end
