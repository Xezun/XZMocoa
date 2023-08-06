//
//  Example20Group101CellViewModel.m
//  Example
//
//  Created by Xezun on 2023/7/24.
//

#import "Example20Group101CellViewModel.h"
#import "Example20Group101CellModel.h"
@import XZURLQuery;

@implementation Example20Group101CellViewModel

+ (void)load {
    Mocoa(@"https://mocoa.xezun.com/examples/20/list/101/:/").viewModelClass = self;
}

- (void)prepare {
    [super prepare];
    
    self.height = 150.0;
    
    Example20Group101CellModel *model = self.model;
    self.title = model.title;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:model.images.count];
    for (NSString *string in model.images) {
        NSURL *url = [NSURL URLWithString:string];
        if (url) {
            [array addObject:url];
        }
    }
    self.images = array;
    if (model.date) {
        self.details = [NSString stringWithFormat:@"%@  %@", model.date, model.comments];
    } else {
        self.details = model.comments;
    }
}

- (void)subViewModel:(__kindof XZMocoaViewModel *)subViewModel didEmit:(XZMocoaEmit)emit {
    if (subViewModel == _editorViewModel) {
        self.images = emit.value;
        [self sendActionsForKeyEvents:@"images"];
    }
}

- (Example20Group101EditorViewModel *)editorViewModel {
    if (_editorViewModel == nil) {
        _editorViewModel = [[Example20Group101EditorViewModel alloc] initWithModel:self.images];
        [self addSubViewModel:_editorViewModel];
    }
    return _editorViewModel;
}

@end
