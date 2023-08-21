//
//  ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "ViewController.h"
@import XZMocoa;
@import ObjectiveC;
@import XZML;

@interface ViewController () <XZMocoaView>

@property (nonatomic, copy) NSArray<NSArray<NSDictionary *> *> *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[
        @[
            @{
                @"title": @"10. 普通 MVVM 模块",
                @"url": [NSURL URLWithString:@"https://mocoa.xezun.com/examples/10/"]
            }, @{
                @"title": @"10. 控制器 MVVM 模块",
                @"url": [NSURL URLWithString:@"https://mocoa.xezun.com/examples/11/"]
            }
        ], @[
            @{
                @"title": @"20. XZMocoaTableView 列表示例",
                @"url": [NSURL URLWithString:@"https://mocoa.xezun.com/examples/20/"],
            }, @{
                @"title": @"21. XZMocoaTableView 差异刷新",
                @"url": [NSURL URLWithString:@"https://mocoa.xezun.com/examples/21/"],
                
            }, @{
                @"title": @"22. XZMocoaTableView 差异刷新",
                @"url": [NSURL URLWithString:@"https://mocoa.xezun.com/examples/22/"]
            }
        ], @[
            @{
                @"title": @"30. XZMocoaTableView 防崩溃测试",
                @"url": [NSURL URLWithString:@"https://mocoa.xezun.com/examples/30/"],
            }, @{
                @"title": @"31. XZMocoaCollectionView 防崩溃测试",
                @"url": [NSURL URLWithString:@"https://mocoa.xezun.com/examples/31/"],
            }
        ]
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = _dataArray[indexPath.section][indexPath.row][@"url"];
    [self.navigationController pushViewControllerWithMocoaURL:url animated:YES];
}

@end
