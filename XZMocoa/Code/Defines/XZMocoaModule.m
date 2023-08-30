//
//  XZMocoa.m
//  XZMocoa
//
//  Created by Xezun on 2021/8/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaModule.h"

/// 将 MocoaURL 中的单个 path 部分解析成 MVVM 模块的 kind 和 name 值。
/// - Parameters:
///   - path: 单个 path 值
///   - kind: 输出值，MocoaKind 值
///   - name: 输出值，MocoaName 值
static void XZMocoaPathParser(NSString *path, XZMocoaKind *kind, XZMocoaName *name);

/// 将 MVVM 模块的 kind 和 name 合成 MocoaURL 中的 path 部分。
/// - Parameters:
///   - kind: MocoaKind
///   - name: MocoaName
static NSString *XZMocoaPathCreate(XZMocoaKind kind, XZMocoaName name);

@interface XZMocoaNamedModules : NSObject <XZMocoaModuleNamedSubscripting>
@end

@interface XZMocoaModule () {
    NSMutableDictionary<XZMocoaKind, id<XZMocoaModuleNamedSubscripting>> *_submodules;
}
@end


@implementation XZMocoaModule

@dynamic viewNibClass;

+ (XZMocoaModule *)moduleForURL:(NSURL *)url {
    NSString *host = url.host;
    if (host == nil) {
        XZLog(@"参数 url 不合法：%@", url);
        return nil;
    }
    // 关于 url 的 path
    // mocoa://www.xezun.com        =>
    // mocoa://www.xezun.com/       => /
    // mocoa://www.xezun.com/path   => /path
    // mocoa://www.xezun.com/path/  => /path
    XZMocoaDomain * const domain = [XZMocoaDomain doaminForName:host];
    if (!domain.provider) {
        domain.provider = [[XZMocoaModuleProvider alloc] init];
    }
    XZMocoaModule * const module = [domain moduleForPath:url.path];
    NSAssert(!module || [module isKindOfClass:[XZMocoaModule class]], @"参数 url 对应的不是 MVVM 模块：%@", url);
    return module;
}

+ (XZMocoaModule *)moduleForURLString:(NSString *)urlString {
    if (urlString == nil) {
        return [self moduleForURL:nil];
    }
    return [self moduleForURL:[NSURL URLWithString:urlString]];
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSGenericException reason:@"非法访问" userInfo:@{
        NSLocalizedRecoverySuggestionErrorKey: @"请使用 -initWithURL: 方法进行初始化"
    }];
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self != nil) {
        _url = url.copy;
    }
    return self;
}

- (void)setViewClass:(Class)viewClass {
    _viewClass = viewClass;
    _viewNibName = nil;
    _viewNibBundle = nil;
}

- (void)setViewNibWithClass:(Class)viewClass name:(NSString *)nibName bundle:(NSBundle *)bundle {
    _viewClass = viewClass;
    _viewNibName = nibName.copy;
    _viewNibBundle = bundle;
}

- (void)setViewNibWithClass:(Class)viewClass name:(NSString *)nibName {
    [self setViewNibWithClass:viewClass name:nibName bundle:[NSBundle bundleForClass:viewClass]];
}

- (void)setViewNibWithClass:(Class)viewClass {
    [self setViewNibWithClass:viewClass name:NSStringFromClass(viewClass)];
}

- (void)enumerateSubmodulesUsingBlock:(void (^NS_NOESCAPE)(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName name, BOOL *stop))block {
    [_submodules enumerateKeysAndObjectsUsingBlock:^(XZMocoaKind kind, id<XZMocoaModuleNamedSubscripting> namedModules, BOOL *stop1) {
        [namedModules enumerateKeysAndObjectsUsingBlock:^(XZMocoaName name, XZMocoaModule *module, BOOL *stop2) {
            block(module, kind, name, stop2);
            *stop1 = *stop2;
        }];
    }];
}


#pragma mark - 访问下级的基础方法

- (XZMocoaModule *)submoduleForKind:(XZMocoaKind)kind forName:(XZMocoaName)name {
    if (kind == nil) kind = XZMocoaKindNone;
    if (name == nil) name = XZMocoaNameNone;
    if (_submodules == nil) {
        _submodules = [NSMutableDictionary dictionary];
    }
    
    id<XZMocoaModuleNamedSubscripting> namedModules = _submodules[kind];
    if (namedModules == nil) {
        namedModules = [[XZMocoaNamedModules alloc] init];
        _submodules[kind] = namedModules;
    }
    XZMocoaModule *submodule = namedModules[name];
    if (submodule == nil) {
        NSURL * const submoduleURL = [self.url URLByAppendingPathComponent:XZMocoaPathCreate(kind, name)];
        submodule = [[XZMocoaModule alloc] initWithURL:submoduleURL];
        namedModules[name] = submodule;
        // 在 domain 中注册新创建的 module
        XZMocoaDomain *domain = [XZMocoaDomain doaminForName:submoduleURL.host];
        [domain setModule:submodule forPath:submoduleURL.path];
    }
    return submodule;
}

- (void)setSubmodule:(XZMocoaModule *)newSubmodule forKind:(XZMocoaKind)kind forName:(XZMocoaName)name {
    if (kind == nil) kind = XZMocoaKindNone;
    if (name == nil) name = XZMocoaNameNone;
    if (newSubmodule == nil) {
        if (_submodules == nil) {
            return;
        }
        id<XZMocoaModuleNamedSubscripting> namedModules = _submodules[kind];
        if (namedModules == nil) {
            return;
        }
        namedModules[name] = nil;
    } else if (_submodules == nil) {
        _submodules = [NSMutableDictionary dictionary];
        XZMocoaNamedModules *namedModules = [[XZMocoaNamedModules alloc] init];
        _submodules[kind] = namedModules;
        namedModules[name] = newSubmodule;
    } else {
        id<XZMocoaModuleNamedSubscripting> namedModules = _submodules[kind];
        if (namedModules == nil) {
            namedModules = [[XZMocoaNamedModules alloc] init];
            _submodules[kind] = namedModules;
        }
        namedModules[name] = newSubmodule;
    }
}

- (XZMocoaModule *)submoduleIfLoadedForKind:(XZMocoaKind)kind forName:(XZMocoaName)name {
    if (kind == nil) kind = XZMocoaKindNone;
    if (name == nil) name = XZMocoaNameNone;
    return _submodules[kind][name];
}

- (XZMocoaModule *)submoduleForName:(XZMocoaName)name {
    return [self submoduleForKind:XZMocoaKindNone forName:name];
}

- (void)setSubmodule:(XZMocoaModule *)newSubmodule forName:(XZMocoaName)name {
    [self setSubmodule:newSubmodule forKind:XZMocoaKindNone forName:name];
}


#pragma mark - 下标存储方法

- (id<XZMocoaModuleNamedSubscripting>)objectForKeyedSubscript:(XZMocoaKind)kind {
    if (kind == nil) kind = XZMocoaKindNone;
    if (_submodules == nil) {
        _submodules = [NSMutableDictionary dictionary];
    }
    id<XZMocoaModuleNamedSubscripting> namedModules = _submodules[kind];
    if (namedModules == nil) {
        namedModules = [[XZMocoaNamedModules alloc] init];
        _submodules[kind] = namedModules;
    }
    return namedModules;
}

- (XZMocoaModule *)submoduleForPath:(NSString *)path {
    XZMocoaModule *submodule = self;
    for (NSString * const subpath in [path componentsSeparatedByString:@"/"]) {
        if (subpath.length == 0) {
            continue; // 忽略空白的
        }
        XZMocoaKind kind = nil;
        XZMocoaName name = nil;
        XZMocoaPathParser(subpath, &kind, &name);
        submodule = [submodule submoduleForKind:kind forName:name];
    }
    return submodule;
}

#pragma mark - DEBUG

- (NSString *)description {
    return [self descriptionWithPadding:0 kind:nil name:nil];
}

- (NSString *)descriptionWithPadding:(NSInteger)padding kind:(nullable XZMocoaKind)kind name:(nullable XZMocoaName)name {
    NSString * const TAB = [@"" stringByPaddingToLength:padding * 4 withString:@" " startingAtIndex:0];
    NSMutableArray *stringsM = [NSMutableArray arrayWithCapacity:_submodules.count + 2];
    
    [stringsM addObject:@"{"];
    
    [stringsM addObject:[NSString stringWithFormat:@"%@    self: %@", TAB, super.description]];
    [stringsM addObject:[NSString stringWithFormat:@"%@    url: %@", TAB, self.url]];
    [stringsM addObject:[NSString stringWithFormat:@"%@    kind: %@", TAB, kind]];
    [stringsM addObject:[NSString stringWithFormat:@"%@    name: %@", TAB, name]];
    
    [stringsM addObject:[NSString stringWithFormat:@"%@    model: %@", TAB, self.modelClass]];
    [stringsM addObject:[NSString stringWithFormat:@"%@    view: %@", TAB, (id)self.viewNibName ?: (id)self.viewClass]];
    [stringsM addObject:[NSString stringWithFormat:@"%@    viewModel: %@", TAB, self.viewModelClass]];
    
    if (_submodules.count > 0) {
        [stringsM addObject:[NSString stringWithFormat:@"%@    submodules: [", TAB]];
        
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:_submodules.count];
        [self enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaName kind, XZMocoaKind name, BOOL *stop) {
            NSString *string = [submodule descriptionWithPadding:padding + 2 kind:kind name:name];
            [items addObject:string];
        }];
        [stringsM addObject:[NSString stringWithFormat:@"%@        %@", TAB, [items componentsJoinedByString:@", "]]];
        
        [stringsM addObject:[NSString stringWithFormat:@"%@    ]", TAB]];
    }
    
    [stringsM addObject:[NSString stringWithFormat:@"%@}", TAB]];
    
    return [stringsM componentsJoinedByString:@"\n"];
}

@end



@implementation XZMocoaModule (XZMocoaExtendedModule)

#pragma mark - 为 tableView、collectionView 提供的便利方法

- (XZMocoaModule *)section {
    return [self submoduleForKind:XZMocoaKindNone forName:XZMocoaNameNone];
}

- (void)setSection:(XZMocoaModule *)section {
    [self setSubmodule:section forKind:XZMocoaKindNone forName:XZMocoaNameNone];
}

- (XZMocoaModule *)sectionForName:(XZMocoaName)name {
    return [self submoduleForKind:XZMocoaKindNone forName:name];
}

- (void)setSection:(XZMocoaModule *)section forName:(XZMocoaName)name {
    [self setSubmodule:section forKind:XZMocoaKindNone forName:name];
}

- (XZMocoaModule *)header {
    return [self submoduleForKind:XZMocoaKindHeader forName:XZMocoaNameNone];
}

- (void)setHeader:(XZMocoaModule *)header {
    [self setSubmodule:header forKind:XZMocoaKindHeader forName:XZMocoaNameNone];
}

- (XZMocoaModule *)headerForName:(XZMocoaName)name {
    return [self submoduleForKind:XZMocoaKindHeader forName:name];
}

- (void)setHeader:(XZMocoaModule *)header forName:(XZMocoaName)name {
    [self setSubmodule:header forKind:XZMocoaKindHeader forName:name];
}

- (XZMocoaModule *)cell {
    return [self submoduleForKind:XZMocoaNameNone forName:XZMocoaNameNone];
}

- (void)setCell:(XZMocoaModule *)cell {
    [self setSubmodule:cell forKind:XZMocoaKindNone forName:XZMocoaNameNone];
}

- (XZMocoaModule *)cellForName:(XZMocoaName)name {
    return [self submoduleForKind:XZMocoaNameNone forName:name];
}

- (void)setCell:(XZMocoaModule *)cell forName:(XZMocoaName)name {
    [self setSubmodule:cell forKind:XZMocoaKindNone forName:name];
}

- (XZMocoaModule *)footer {
    return [self submoduleForKind:XZMocoaKindFooter forName:XZMocoaNameNone];
}

- (void)setFooter:(XZMocoaModule *)footer {
    [self setSubmodule:footer forKind:XZMocoaKindFooter forName:XZMocoaNameNone];
}

- (XZMocoaModule *)footerForName:(XZMocoaName)name {
    return [self submoduleForKind:XZMocoaKindFooter forName:name];
}

- (void)setFooter:(XZMocoaModule *)footer forName:(XZMocoaName)name {
    [self setSubmodule:footer forKind:XZMocoaKindFooter forName:name];
}

@end


@implementation XZMocoaModuleProvider

+ (NSURL *)moduleURLForDomain:(XZMocoaDomain *)domain atPath:(NSString *)path {
    NSString * const name   = domain.name;
    NSString * const string = [NSString stringWithFormat:@"mocoa://%@%@", name, path];
    NSURL    * const url    = [NSURL URLWithString:string];
    NSAssert(url, @"参数 name=%@ 和 path=%@ 不是合法的 URL 部分", name, path);
    return url;
}

- (id)domain:(XZMocoaDomain *)domain moduleForPath:(nonnull NSString *)path {
    // 创建模块
    NSURL         * const url    = [XZMocoaModuleProvider moduleURLForDomain:domain atPath:path];
    XZMocoaModule * const module = [[XZMocoaModule alloc] initWithURL:url];
    
    // 关联上级模块
    if (![path isEqualToString:@"/"]) {
        NSString      * const superPath   = path.stringByDeletingLastPathComponent;
        XZMocoaModule * const superModule = [domain moduleForPath:superPath];
        
        XZMocoaKind subKind = nil;
        XZMocoaName subName = nil;
        XZMocoaPathParser(path.lastPathComponent, &subKind, &subName);
        if (![superModule submoduleIfLoadedForKind:subKind forName:subName]) {
            [superModule setSubmodule:module forKind:subKind forName:subName];
        }
    }
    
    return module;
}


@end


static void XZMocoaPathParser(NSString *path, XZMocoaKind *kind, XZMocoaName *name) {
    NSRange const range = [path rangeOfString:@":"];
    if (range.location == NSNotFound) {
        *kind = XZMocoaKindNone;
        *name = path;
    } else {
        *kind = [path substringToIndex:range.location];
        *name = [path substringFromIndex:range.location + 1];
    }
}

static NSString *XZMocoaPathCreate(XZMocoaKind kind, XZMocoaName name) {
    return (kind.length ? [NSString stringWithFormat:@"%@:%@", kind, name] : (name.length ? name : @":"));
}


@implementation XZMocoaNamedModules {
    NSMutableDictionary *_namedModules;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _namedModules = [NSMutableDictionary dictionary];
    }
    return self;
}

- (XZMocoaModule *)objectForKeyedSubscript:(XZMocoaName)name {
    if (name == nil) name = XZMocoaNameNone;
    return _namedModules[name];
}

- (void)setObject:(XZMocoaModule *)submodule forKeyedSubscript:(XZMocoaName)name {
    if (name == nil) name = XZMocoaNameNone;
    _namedModules[name] = submodule;
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^NS_NOESCAPE)(XZMocoaName, XZMocoaModule *, BOOL *))block {
    [_namedModules enumerateKeysAndObjectsUsingBlock:block];
}

@end
