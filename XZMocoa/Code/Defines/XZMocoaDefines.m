//
//  XZMocoaDefines.m
//  XZMocoa
//
//  Created by Xezun on 2021/11/5.
//

#import "XZMocoaDefines.h"

CGFloat const XZMocoaViewDimensionMinimum = 0.000001;
CGSize  const XZMocoaViewSizeMinimum      = (CGSize){XZMocoaViewDimensionMinimum, XZMocoaViewDimensionMinimum};

CGFloat const XZMocoaTableViewHeaderFooterHeight = XZMocoaViewDimensionMinimum;
CGSize  const XZMocoaCollectionViewItemSize      = XZMocoaViewSizeMinimum;

XZMocoaName const XZMocoaNameNone    = @"";
XZMocoaKind const XZMocoaKindNone    = @"";
XZMocoaKind const XZMocoaKindHeader  = @"header";
XZMocoaKind const XZMocoaKindFooter  = @"footer";
XZMocoaKind const XZMocoaKindSection = @"";
XZMocoaKind const XZMocoaKindCell    = @"";

XZMocoaName const XZMocoaNamePlaceholder = @"XZMocoaNamePlaceholder";
