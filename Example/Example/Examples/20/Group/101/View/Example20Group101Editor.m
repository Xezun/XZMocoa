//
//  Example20Group101Editor.m
//  Example
//
//  Created by Xezun on 2023/7/31.
//

#import "Example20Group101Editor.h"
#import "Example20Group101CellViewModel.h"
@import XZMocoa;
@import SDWebImage;

@interface Example20Group101Editor ()

@end

@implementation Example20Group101Editor

@dynamic viewModel;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Editor";
    }
    return self;
}

- (void)dealloc {
    [self.viewModel submit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:(UIBarButtonItemStylePlain) target:self action:@selector(navBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)navBarButtonAction:(UIBarButtonItem *)sender {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        sender.title = @"排序";
    } else {
        [self.tableView setEditing:YES animated:YES];
        sender.title = @"确定";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.imageView sd_setImageWithURL:self.viewModel.images[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [self.viewModel moveImageAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
