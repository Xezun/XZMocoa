//
//  Example20Group101Cell.m
//  Example
//
//  Created by Xezun on 2023/7/24.
//

#import "Example20Group101Cell.h"
#import "Example20Group101Editor.h"
#import "Example20Group101CellViewModel.h"
@import SDWebImage;

@implementation Example20Group101Cell

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/101/:").viewNibClass = self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)viewModelDidChange {
    Example20Group101CellViewModel *viewModel = self.viewModel;
    
    self.titleLabel.text = viewModel.title;
    self.detailsLabel.text = viewModel.details;
    // 监听图片的变化
    [viewModel addTarget:self action:@selector(imagesChanged:) forKeyEvents:@"images"];
}

- (void)imagesChanged:(Example20Group101CellViewModel *)viewModel {
    NSLog(@"images changed");
    [viewModel.images enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL *stop) {
        [self.imageViews[idx] sd_setImageWithURL:url];
        *stop = (idx == (self.imageViews.count - 1));
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Example20Group101CellViewModel *viewModel = self.viewModel;
    // 将二级页面作为当前模块的一部分，由 View 直接展示
    // 二级页面的 ViewModel 作为 subViewModel 与当前页面的 ViewModel 进行数据交互。
    // 另，本例中，二级页面实际上完全可以与当前页面共用同一个 ViewModel 处理起来更简单，
    // 也就是说，对于不复杂的页面，一个 ViewModel 实际上可以与多个看上去独立 View 对应。
    Example20Group101Editor *editor = [[Example20Group101Editor alloc] init];
    editor.viewModel = viewModel.editorViewModel;
    [self.navigationController pushViewController:editor animated:YES];
}


@end
