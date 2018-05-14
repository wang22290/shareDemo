//
//  AppDelegate.m
//  shareP
//
//  Created by wagn on 2018/5/2.
//  Copyright © 2018年 wagn. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//授权登录操作
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *urlStr = url.absoluteString;
    NSString *sechemes = url.scheme;
    if([[self getAppSchemeString] isEqualToString:sechemes]){
        
        if ([urlStr containsString:@"articleTitle"] && [urlStr containsString:@"articleUrl"]) {
            NSRange range1 = [urlStr rangeOfString:@"="];
            NSRange range2 = [urlStr rangeOfString:@"&"];
            NSString *articleTitle = [urlStr substringWithRange:NSMakeRange(range1.location + range1.length, range2.location - range1.location - range1.length)];
            
            NSString *stateStr = [urlStr substringFromIndex:range2.location+1];
            NSRange range3 = [stateStr rangeOfString:@"="];
            NSString *articleUrl = [stateStr substringFromIndex:range3.location+1];
            NSLog(@"%@====%@",articleTitle,articleUrl);
            
            

                //跳转代码不方便透漏，不好意思了
        }
        
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.taiyi.shareP"];
    if ([userDefaults boolForKey:@"has-new-share"])
    {   NSLog(@"新的分享 : %@", [userDefaults valueForKey:@"share-url"]);
        NSString *imageUrl = [userDefaults valueForKey:@"share-image-url"];
        [[NSUserDefaults standardUserDefaults]setObject:imageUrl forKey:@"imageUrl"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        //重置分享标识
        [userDefaults setBool:NO forKey:@"has-new-share"];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //获取共享的UserDefaults
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.taiyi.shareP"];
    if ([userDefaults boolForKey:@"has-new-share"])
    {   NSLog(@"新的分享 : %@", [userDefaults valueForKey:@"share-url"]);
        NSString *imageUrl = [userDefaults valueForKey:@"share-image-url"];
        [[NSUserDefaults standardUserDefaults]setObject:imageUrl forKey:@"imageUrl"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        //重置分享标识
        [userDefaults setBool:NO forKey:@"has-new-share"];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (NSString *)getAppSchemeString {
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    
    //取出infoDict中的 urltyps 数组
    NSArray * urlTypesArr = infoDict[@"CFBundleURLTypes"];
    
    //再取出 urlTypesArr 数组中 的 URL schemes字典. 我们现在只设置了一个
    NSDictionary *urlSchemesDic = urlTypesArr[0];
    
    //在取出 urlSchemesDic 字典中的 scheme 协议头
    NSArray * schemesArr = urlSchemesDic[@"CFBundleURLSchemes"];
    
    //再取出 schemesArr 中的字典
    NSString * scheme = schemesArr[0];
    
    return scheme;
}

@end
