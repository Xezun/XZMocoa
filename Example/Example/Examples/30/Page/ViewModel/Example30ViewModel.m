//
//  Example30ViewModel.m
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import "Example30ViewModel.h"
@import XZExtensions;
@import YYModel;

@implementation Example30ViewModel

- (void)prepare {
    [super prepare];

    XZMocoaModule *module = XZMocoa(@"https://mocoa.xezun.com/examples/30/table/");
    
    NSArray *data = @[@{
        @"group": @"100",
        @"model": @{ @"text": @"测试 cell 模块未注册 Model、View、ViewModel" }
    }, @{
        @"group": @"101",
        @"model": @{ @"text": @"测试 cell 模块未注册 View、ViewModel" }
    }, @{
        @"group": @"102",
        @"model": @{ @"text": @"测试 cell 模块未注册 Model、ViewModel" }
    }, @{
        @"group": @"103",
        @"model": @{ @"text": @"测试 cell 模块未注册 Model、View" }
    }, @{
        @"group": @"104",
        @"model": @{ @"text": @"测试 cell 模块未注册 View" }
    }, @{
        @"group": @"105",
        @"model": @{ @"text": @"测试 cell 模块未注册 Model" }
    }, @{
        @"group": @"106",
        @"model": @{ @"text": @"测试 cell 模块未注册 ViewModel" }
    }, @{
        @"group": @"107",
        @"model": @{ @"text": @"测试 cell 模块正常注册" }
    }, @{
        @"group": @"108",
        @"title": @"测试 Header 模块未注册 Model、View、ViewModel",
        @"model": @{ @"text": @"测试 Header、Footer 模块未注册 Model、View、ViewModel" },
        @"notes": @"测试 Footer 模块未注册 Model、View、ViewModel"
    }, @{
        @"group": @"109",
        @"title": @"测试 Header 模块未注册 Model、View",
        @"model": @{ @"text": @"测试 Header、Footer 模块未注册 Model、View" },
        @"notes": @"测试 Footer 模块未注册 Model、View"
    }, @{
        @"group": @"110",
        @"title": @"测试 Header 模块未注册 Model",
        @"model": @{ @"text": @"测试 Header、Footer 模块未注册 Model" },
        @"notes": @"测试 Footer 模块未注册 Model"
    }];
    NSArray *groups = [data xz_map:^id(NSDictionary *dict, NSInteger idx, BOOL * _Nonnull stop) {
        XZMocoaModule *submodule = [module submoduleForName:dict[@"group"]];
        return [submodule.modelClass yy_modelWithDictionary:dict];
    }];
    
    _tableViewModel = [[XZMocoaTableViewModel alloc] initWithModel:groups];
    _tableViewModel.module = module;
    [self addSubViewModel:_tableViewModel];
}

@end
