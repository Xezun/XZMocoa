//
//  Example20Group102Cell.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Group102Cell.h"
#import "Example20Group102CellViewModel.h"
@import SDWebImage;

@interface Example20Group102Cell () <XZPageViewDelegate, XZPageViewDataSource>

@end

@implementation Example20Group102Cell

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/102/:/").viewNibClass = self;
}

@dynamic viewModel;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pageView.isLoopable = YES;
    self.pageControl.currentIndicatorShape = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 10, 6.0) cornerRadius:3.0];
    
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    [self.pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:(UIControlEventValueChanged)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)viewModelDidChange {
    Example20Group102CellViewModel *viewModel = self.viewModel;
    self.pageControl.numberOfPages = viewModel.images.count;
    self.pageControl.currentPage = 0;
    [self.pageView reloadData];
    self.pageView.currentPage = 0;
}

- (void)pageControlValueChanged:(XZPageControl *)pageControl {
    [self.pageView setCurrentPage:pageControl.currentPage animated:YES];
}

- (NSInteger)numberOfPagesInPageView:(XZPageView *)pageView {
    Example20Group102CellViewModel *viewModel = self.viewModel;
    return viewModel.images.count;
}

- (UIView *)pageView:(XZPageView *)pageView viewForPageAtIndex:(NSInteger)index reusingView:(UIImageView *)reusingView {
    if (reusingView == nil) {
        reusingView = [[UIImageView alloc] initWithFrame:pageView.bounds];
        reusingView.contentMode = UIViewContentModeScaleAspectFill;
    }
    Example20Group102CellViewModel *viewModel = self.viewModel;
    [reusingView sd_setImageWithURL:viewModel.images[index]];
    return reusingView;
}

- (UIView *)pageView:(XZPageView *)pageView prepareForReusingView:(UIImageView *)reusingView {
    reusingView.image = nil;
    return reusingView;
}

- (void)pageView:(XZPageView *)pageView didPageToIndex:(NSInteger)index {
    self.pageControl.currentPage = index;
}

@end
