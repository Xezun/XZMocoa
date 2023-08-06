//
//  XZMocoaDomain.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/29.
//

#import "XZMocoaDomain.h"

static NSMutableDictionary<NSString *, XZMocoaDomain *> *_domainTable = nil;

static BOOL isValidPath(NSString *path) {
    if ([path isEqualToString:@"/"]) {
        return YES;
    }
    NSString *pattern = @"^((/\\w+\\:\\w*)|(/\\w+)|(/\\:))+$";
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSRange const range = [reg rangeOfFirstMatchInString:path options:0 range:NSMakeRange(0, path.length)];
    return range.location == 0 && range.length == path.length;
}

@implementation XZMocoaDomain {
    // TODO: 缓存过期功能
    NSMutableDictionary<NSString *, id> *_keyedModules;
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

+ (id)moduleForURL:(NSURL *)url {
    return [[self doaminForName:url.host] moduleForPath:url.path];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name.copy;
        _keyedModules = [NSMutableDictionary dictionary]; // dict
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
    
    id<XZMocoaModuleProvider> provider = self.provider;
    if (provider == nil) {
        return nil;
    }
    
    NSAssert(isValidPath(path), @"参数 path 不合法：%@", path);
    module = [self.provider domain:self moduleForName:self.name atPath:path];
    _keyedModules[path] = module;
    return module;
}

- (void)setModule:(id)module forPath:(NSString *)path {
    NSAssert(isValidPath(path), @"参数 path 不合法：%@", path);
    _keyedModules[path] = module;
}

@end
