//
//  Example20Group100CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group100CellViewModel.h"
#import "Example20Group100CellModel.h"
@import XZURLQuery;
@import XZExtensions;

@implementation Example20Group100CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20/list/100/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 100;
    
    Example20Group100CellModel *model = self.model;
    self.title = model.title;
    self.image = model.image;
    if (model.date.length > 0) {
        self.details = [NSString stringWithFormat:@"%@  %@", model.date, model.comments];
    } else {
        self.details = model.comments;
    }
} 

- (void)tableView:(XZMocoaTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 通过 url 参数传值
    Example20Group100CellModel *model = self.model;
    NSURL *url = [NSURL xz_URLWithFormat:@"https://mocoa.xezun.com/examples/20/content/?url=%@", model.url.xz_stringByAddingPercentEncoding];
    [tableView.navigationController pushViewControllerWithMocoaURL:url animated:YES];
}

@end
