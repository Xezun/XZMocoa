//
//  XZMocoaTableCellViewModel.m
//  
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaTableCellViewModel.h"

@implementation XZMocoaTableCellViewModel

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    if (self.frame.size.height == height) {
        return;
    }
    frame.size.height = height;
    self.frame = frame;
}

- (void)wasSelectedInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {

}

- (void)willBeDisplayedInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {

}

- (void)didEndBeingDisplayedInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {

}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, identifier = %@; height = %g>", self.class, self, self.identifier, self.height];
}


@end
