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

- (void)prepare {
    [super prepare];
    _isHeaderRefreshing = NO;
    _isFooterRefreshing = NO;
    
    _cursor = 100;
    _dataArray = [NSMutableArray array];
    
    XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/examples/20/table/");
    _tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:_dataArray];
    _tableViewModel.rowAnimation = UITableViewRowAnimationFade;
    _tableViewModel.module = module;
    [self addSubViewModel:_tableViewModel];
    
    [self refreshingHeaderDidBeginAnimating];
}

- (void)setHeaderRefreshing:(BOOL)isHeaderRefreshing {
    _isHeaderRefreshing = isHeaderRefreshing;
    [self sendActionsForKeyEvents:@"isHeaderRefreshing"];
}

- (void)setFooterRefreshing:(BOOL)isFooterRefreshing {
    _isFooterRefreshing = isFooterRefreshing;
    [self sendActionsForKeyEvents:@"isFooterRefreshing"];
}

- (void)refreshingHeaderDidBeginAnimating {
    if (_isFooterRefreshing) {
        self.isHeaderRefreshing = NO;
        return;
    }
    if (_isHeaderRefreshing) {
        return;
    }
    _isHeaderRefreshing = YES;
    [self loadData:0 completion:^(NSArray *data) {
        if (data.count > 0) {
            self->_tableViewModel.rowAnimation = UITableViewRowAnimationFade;
            [self->_tableViewModel performBatchUpdates:^{
                [self->_dataArray removeAllObjects];
                [self->_dataArray addObjectsFromArray:data];
            } completion:^(BOOL finished) {
                self.isHeaderRefreshing = NO;
            }];
        } else {
            self.isHeaderRefreshing = NO;
        }
    }];
}

- (void)refreshingFooterDidBeginAnimating {
    if (_isHeaderRefreshing) {
        self.isFooterRefreshing = NO;
        return;
    }
    if (_isFooterRefreshing) {
        return;
    }
    _isFooterRefreshing = YES;
    [self loadData:_dataArray.count completion:^(NSArray *data) {
        if (data.count > 0) {
            self->_tableViewModel.rowAnimation = UITableViewRowAnimationTop;
            [self->_tableViewModel performBatchUpdates:^{
                [self->_dataArray addObjectsFromArray:data];
            } completion:^(BOOL finished) {
                self.isFooterRefreshing = NO;
            }];
        } else {
            self.isFooterRefreshing = NO;
        }
    }];
}

/// 模拟网络加载
- (void)loadData:(NSInteger)page completion:(void (^)(NSArray *data))completion {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        // 模拟后端查询数据
        NSURL          *database = [NSBundle.mainBundle URLForResource:@"Example20Model" withExtension:@"json"];
        NSData         *data     = [NSData dataWithContentsOfURL:database];
        NSDictionary   *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray        *items    = response[@"data"];
        NSMutableArray *array    = [NSMutableArray arrayWithCapacity:8];
        if (page == 0) { // 下拉刷新
            if (self->_cursor > 1) {
                self->_cursor = MAX(self->_cursor - arc4random_uniform(2) - 1, 1);
                [array addObject:items.firstObject];
                NSArray *subArray = [items subarrayWithRange:NSMakeRange(self->_cursor, 7)];
                [array addObjectsFromArray:subArray];
            } else {
                // no more new data
            }
        } else {
            NSInteger count = items.count;
            NSInteger index = self->_cursor + page;
            if (index < count) {
                NSArray *subArray = [items subarrayWithRange:NSMakeRange(index, MIN(count - index, 8))];;
                [array addObjectsFromArray:subArray];
            } else {
                // no more history data
            }
        }
        
        // 模拟网络模块处理数据
        XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/examples/20/table/");
        NSMutableArray *list = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            XZMocoaName name = dict[@"group"];
            if (!name) continue;
            XZMocoaModule *submodule = [module sectionForName:name];
            id item = [submodule.modelClass yy_modelWithDictionary:dict];
            if (item) {
                [list addObject:item];
            }
        }
        
        NSTimeInterval delay = arc4random_uniform(2000) / 1000.0 + 0.5;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion(list);
        });
    });
}


@end
