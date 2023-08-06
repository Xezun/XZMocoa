//
//  Example20Model.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "Example20Model.h"
@import YYModel;

@implementation Example20Model

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    XZMocoaModule *listModule = Mocoa(@"https://mocoa.xezun.com/examples/20/list/");
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:self.list.count];
    for (NSDictionary *dict in self.list) {
        XZMocoaName name = dict[@"group"];
        if (!name) continue;
        XZMocoaModule *module = [listModule sectionForName:name];
        id item = [module.modelClass yy_modelWithDictionary:dict];
        if (item) {
            [list addObject:item];
        }
    }
    self.list = list;
    
    return YES;
}



@end
