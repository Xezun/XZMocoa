//
//  Example20Group100CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group100CellViewModel.h"
#import "Example20Group100CellModel.h"
@import XZURLQuery;

@implementation Example20Group100CellViewModel

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/100/:/").viewModelClass = self;
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

- (void)tableView:(id<XZMocoaView>)tableView didSelectRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // 目标作为独立模块，直接打开，通过 url 参数传值
    Example20Group100CellModel *model = self.model;
    XZURLQuery *query = [XZURLQuery queryForURLString:@"https://mocoa.xezun.com/examples/20/content/"];
    query[@"url"] = model.url;
    [tableView.navigationController pushViewControllerWithMocoaURL:query.url animated:YES];
}

@end
