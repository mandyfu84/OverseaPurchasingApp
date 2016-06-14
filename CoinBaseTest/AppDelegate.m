//
//  AppDelegate.m
//  CoinBaseTest
//
//  Created by John Hsu on 2016/4/23.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AppDelegate.h"
#import <coinbase-official/CoinbaseOAuth.h>

#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([[url scheme] isEqualToString:@"com.test.coinbasesandboxtest"]) {
        // This is a redirect from the Coinbase OAuth web page or app.
        [CoinbaseOAuth finishOAuthAuthenticationForUrl:url
                                              clientId:kCoinbaseDemoClientID
                                          clientSecret:kCoinbaseDemoClientSecret
                                            completion:^(id result, NSError *error) {
                                                if (error) {
                                                    // Could not authenticate.
                                                    [[[UIAlertView alloc] initWithTitle:@"OAuth Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                                                } else {
                                                    // Tokens successfully obtained!
                                                    ViewController *vc = (ViewController *)self.window.rootViewController;
                                                    [vc authenticationComplete:result];
                                                }
                                            }];
        return YES;
    }
    return NO;
    
}

@end
