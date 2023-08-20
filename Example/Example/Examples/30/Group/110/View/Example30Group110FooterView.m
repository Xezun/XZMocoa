//
//  Example30Group110FooterView.m
//  Example
//
//  Created by Xezun on 2023/8/21.
//

#import "Example30Group110FooterView.h"

@implementation Example30Group110FooterView

+ (void)load {
    XZMocoa(@"https://mocoa.xezun.com/examples/30/table/110/footer:/").viewClass = self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.whiteColor;
        self.backgroundView = view;
    }
    return self;
}

- (void)viewModelDidChange {
    self.textLabel.text = self.viewModel.model;
}

@end
