//
//  AppDelegate.m
//  Example
//
//  Created by Xezun on 2023/7/23.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    return YES;
}

- (void)foobar:(id)sender {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"path: %@", path);
    
    NSURL *url = [NSBundle.mainBundle URLForResource:@"data" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        [result addObject:@{
            @"group": dict[@"images"] ? @"101" : @"100",
            @"items": @[ dict ]
        }];
    }
    
    NSData *newData = [NSJSONSerialization dataWithJSONObject:@{
        @"code": @(0),
        @"message": @"success",
        @"data": result
    } options:0 error:nil];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/Example20Model.json", path];
    [NSFileManager.defaultManager createFileAtPath:filePath contents:newData attributes:nil];
    [result removeAllObjects];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
