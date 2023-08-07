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
    NSInteger _cursor;
}

- (instancetype)initWithModel:(id)model {
    return [super initWithModel:[[Example20Model alloc] init]];
}

- (void)prepare {
    _cursor = 100;
    _dataArray = [NSMutableArray array];
    
    XZMocoaModule *module = Mocoa(@"https://mocoa.xezun.com/examples/20/list/");
    _tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:_dataArray];
    _tableViewModel.rowAnimation = UITableViewRowAnimationFade;
    _tableViewModel.module = module;
    [self addSubViewModel:_tableViewModel];
    
    [super prepare];
}

- (void)headerRefreshAction:(void (^)(BOOL hasData))completion {
    [self loadData:0 completion:^(NSArray *data) {
        if (data.count > 0) {
            self->_tableViewModel.rowAnimation = UITableViewRowAnimationBottom;
            [self->_tableViewModel performBatchUpdates:^{
                [self->_dataArray removeAllObjects];
                [self->_dataArray addObjectsFromArray:data];
            }];
            completion(YES);
        } else {
            completion(NO);
        }
    }];
}

- (void)footerRefreshAction:(void (^)(BOOL hasData))completion {
    [self loadData:_dataArray.count completion:^(NSArray *data) {
        if (data.count > 0) {
            [self->_tableViewModel performBatchUpdates:^{
                [self->_dataArray addObjectsFromArray:data];
            }];
            completion(YES);
        } else {
            completion(NO);
        }
    }];
}

/// 模拟网络加载
- (void)loadData:(NSInteger)page completion:(void (^)(NSArray *data))completion {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        Example20Model *model = self.model;
        if (model.data.count == 0) {
            NSURL *url = [NSBundle.mainBundle URLForResource:@"Example20Model" withExtension:@"json"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [model yy_modelSetWithDictionary:dict];
        }
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:6];
        if (page == 0) { // 下拉刷新
            if (self->_cursor > 1) {
                self->_cursor = MAX(self->_cursor - arc4random_uniform(3) - 1, 1);
                [array addObject:model.data.firstObject];
                NSArray *subArray = [model.data subarrayWithRange:NSMakeRange(self->_cursor, 5)];
                [array addObjectsFromArray:subArray];
            } else {
                // no more new data
            }
        } else {
            NSInteger count = model.data.count;
            NSInteger index = self->_cursor + page;
            if (index < count) {
                NSArray *subArray = [model.data subarrayWithRange:NSMakeRange(index, MIN(count - index, 6))];;
                [array addObjectsFromArray:subArray];
            } else {
                // no more history data
            }
        }
        
        NSTimeInterval delay = arc4random_uniform(1000) / 500.0 + 0.3;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion(array);
        });
    });
}


@end
