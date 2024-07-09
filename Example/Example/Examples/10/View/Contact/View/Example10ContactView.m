//
//  Example10ContactView.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "Example10ContactView.h"
#import "Example10ContactViewModel.h"
@import SDWebImage;

@implementation Example10ContactView

+ (Example10ContactView *)contactView {
    UINib *nib = [UINib nibWithNibName:@"Example10ContactView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.wrapperView.layer.cornerRadius = 10;
    self.wrapperView.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)viewModelDidChange {
    Example10ContactViewModel *viewModel = self.viewModel;
    
    self.nameLabel.text = viewModel.name;
    [self.photoImageView sd_setImageWithURL:viewModel.photo];
    self.phoneLabel.text = viewModel.phone;
    self.addressLabel.text = viewModel.address;
    
    [self invalidateIntrinsicContentSize];
}

@end
