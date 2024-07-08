//
//  XZMocoaDomain.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/29.
//

#import "XZMocoaDomain.h"
#import "XZMocoaDefines.h"

static NSMutableDictionary<NSString *, XZMocoaDomain *> *_domainTable = nil;

#if DEBUG
static BOOL isValidPath(NSString *path) {
    if ([path isEqualToString:@"/"]) {
        return YES;
    }
    NSString *pattern = @"^((/\\w+\\:\\w*)|(/\\w+)|(/\\:))+$";
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSRange const range = [reg rangeOfFirstMatchInString:path options:0 range:NSMakeRange(0, path.length)];
    return range.location == 0 && range.length == path.length;
}
#endif

@implementation XZMocoaDomain {
    // TODO: 缓存过期功能
    NSMutableDictionary<NSString *, id> *_keyedModules;
}

+ (id)moduleForURL:(NSURL *)url {
    return [[self doaminForName:url.host] moduleForPath:url.path];
}

+ (XZMocoaDomain *)doaminForName:(NSString *)name {
    NSParameterAssert(name && name.length > 0);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _domainTable = [NSMutableDictionary dictionary];
    });
    
    XZMocoaDomain *domain = _domainTable[name];
    if (domain == nil) {
        domain = [[XZMocoaDomain alloc] initWithName:name];
        _domainTable[name] = domain;
    }
    return domain;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name.copy;
        _keyedModules = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)moduleForPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        path = @"/"; // path 为空，等同根路径
    }
    
    id module = _keyedModules[path];
    if (module != nil) {
        return module;
    }
    
    id<XZMocoaDomainModuleProvider> provider = self.provider;
    if (provider == nil) {
        return nil;
    }
    
#if DEBUG
    if (!isValidPath(path)) {
        XZLog(@"参数 path 不合法：%@", path);
        return nil;
    }
#endif
    
    module = [self.provider domain:self moduleForPath:path];
    _keyedModules[path] = module;
    return module;
}

- (void)setModule:(id)module forPath:(NSString *)path {
#if DEBUG
    if (!isValidPath(path)) {
        XZLog(@"参数 path 不合法：%@", path);
        return;
    }
#endif
    _keyedModules[path] = module;
}

@end
