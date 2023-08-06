//
//  Example20ViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "Example20ViewModel.h"
#import "Example20Model.h"

@implementation Example20ViewModel {
    NSMutableArray *_dataArray;
}

- (void)prepare {
    _dataArray = [NSMutableArray array];
    
    XZMocoaModule *module = Mocoa(@"https://mocoa.xezun.com/examples/20/list/");
    _tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:_dataArray];
    _tableViewModel.module = module;
    [self addSubViewModel:_tableViewModel];
    
    [super prepare];
    
    [self loadData];
}

- (void)loadData {
    NSURL *url = [NSBundle.mainBundle URLForResource:@"Example20Model" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    Example20Model *model = [Example20Model yy_modelWithDictionary:dict];
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:model.list];
    [_tableViewModel reloadData];
}


@end
