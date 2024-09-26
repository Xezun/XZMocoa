//
//  Example20Group101CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/24.
//

#import "Example20Group101CellViewModel.h"
#import "Example20Group101CellModel.h"

@implementation Example20Group101CellViewModel

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/20/table/101/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 150.0;
    
    Example20Group101CellModel *model = self.model;
    self.title = model.title;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:model.images.count];
    for (NSString *string in model.images) {
        NSURL *url = [NSURL URLWithString:string];
        if (url) {
            [array addObject:url];
        }
    }
    self.images = array;
    if (model.date) {
        self.details = [NSString stringWithFormat:@"%@  %@", model.date, model.comments];
    } else {
        self.details = model.comments;
    }
}

- (void)tableView:(XZMocoaTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 通过模块初始化传递参数
    Example20Group101CellModel *model = self.model;
    NSURL *url = [NSURL URLWithString:@"https://mocoa.xezun.com/examples/20/content/"];
    [tableView.navigationController pushViewControllerWithMocoaURL:url options:@{ @"url": model.url } animated:YES];
}

@end
