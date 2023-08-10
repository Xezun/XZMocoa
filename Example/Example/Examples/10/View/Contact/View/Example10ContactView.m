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

- (CGSize)sizeThatFits:(CGSize)size {
    if (_addressLabel.text.length == 0) {
        return CGSizeMake(size.width, 12.0);
    }
    CGSize addressSize = [_addressLabel sizeThatFits:CGSizeMake(size.width - 40.0, 0)];
    return CGSizeMake(size.width, 20.0 + 80.0 + 10.0 + addressSize.height + 20.0);
}

- (void)viewModelDidChange {
    Example10ContactViewModel *viewModel = self.viewModel;
    
    self.nameLabel.text = viewModel.name;
    [self.photoImageView sd_setImageWithURL:viewModel.photo];
    self.phoneLabel.text = viewModel.phone;
    self.addressLabel.text = viewModel.address;
}

@end
