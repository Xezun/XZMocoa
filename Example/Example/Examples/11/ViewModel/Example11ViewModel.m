//
//  Example11ViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "Example11ViewModel.h"
#import "Example11Model.h"
@import YYModel;

@implementation Example11ViewModel

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (instancetype)initWithModel:(id)model {
    return [super initWithModel:[Example11Model new]];
}

- (void)prepare {
    [super prepare];
    
    [self loadData];
}

- (void)loadData {
    NSDictionary *dict = @{
        @"card": @"contact",
        @"firstName": @"Foo",
        @"lastName": @"Bar",
        @"photo": @"https://developer.apple.com/assets/elements/icons/xcode/xcode-64x64_2x.png",
        @"phone": @"13923459876",
        @"address": @"北京市海淀区人民路幸福里小区7号楼6单元503室",
        @"title": @"示例说明",
        @"content": @"本示例演示了，如何使用 MVVM 设计模式，基于 ViewController 进行业务开发。"
    };
    [self.model yy_modelSetWithDictionary:dict];
    
    [self dataDidChange];
}

- (void)dataDidChange {
    Example11Model *data = self.model; // [self loadDataFromDatabase];
    self.name    = [NSString stringWithFormat:@"%@ %@", data.firstName, data.lastName];
    self.photo   = [NSURL URLWithString:data.photo];
    self.phone   = [self formatPhoneNumber:data.phone];
    self.address = data.address;
    self.title   = data.title;
    self.content = data.content;
    [self sendActionsForKeyEvents:nil];
}

- (NSString *)formatPhoneNumber:(NSString *)phone {
    if (phone.length <= 3) {
        return phone;
    }
    NSString *part1 = [phone substringToIndex:3];
    if (phone.length <= 7) {
        NSString *part2 = [phone substringFromIndex:3];
        return [NSString stringWithFormat:@"%@-%@", part1, part2];
    }
    NSString *part2 = [phone substringWithRange:NSMakeRange(3, phone.length - 3 - 4)];
    NSString *part3 = [phone substringFromIndex:phone.length - 4];
    return [NSString stringWithFormat:@"%@-%@-%@", part1, part2, part3];
}

@end
