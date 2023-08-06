//
//  Example21ContactBookTestViewController.m
//  Example
//
//  Created by Xezun on 2021/7/12.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactBookTestViewController.h"

@interface Example21ContactBookTestViewController ()

@property (nonatomic, copy) NSArray<NSString *> *dataArray;

@end

@implementation Example21ContactBookTestViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"请选择操作";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"请选择操作";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[
        @"恢复默认列表",
        @"列表切换测试-列表1", @"列表切换测试-列表2",
        @"姓名正序", @"姓名反序",
        @"号码正序", @"号码反序",
        @"在头部添加一个", @"在中间添加一个", @"在尾部添加一个",
        @"删除第一个", @"删除最后一个", @"随即删除一个",
        @"移除所有"
    ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
    // 延迟 0.5 以便返回页面查看动画效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate testVC:self didSelectTestAction:indexPath.row];
    });
}

@end
