//
//  ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "ViewController.h"
@import XZMocoa;
@import ObjectiveC;

@interface ViewController () <XZMocoaView>

@property (nonatomic, copy) NSArray<NSArray<NSURL *> *> *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[
        @[
            [NSURL URLWithString:@"https://mocoa.xezun.com/examples/10/"],
            [NSURL URLWithString:@"https://mocoa.xezun.com/examples/11/"]
        ], @[
            [NSURL URLWithString:@"https://mocoa.xezun.com/examples/20/"],
            [NSURL URLWithString:@"https://mocoa.xezun.com/examples/21/"],
            [NSURL URLWithString:@"https://mocoa.xezun.com/examples/22/"]
        ]
    ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = self.dataArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewControllerWithMocoaURL:url animated:YES];
}

@end
