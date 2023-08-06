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
    [self heightDidChange];
}

- (void)heightDidChange {
    [self emit:XZMocoaEmitNone value:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView willDisplayRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didEndDisplayingRow:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, identifier = %@; height = %g>", self.class, self, self.identifier, self.height];
}


@end
