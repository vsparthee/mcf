//
//  AppDelegate.m
//  myCashFlow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftMenuVC.h"
#import "VENTouchLock.h"
#import "SampleLockSplashViewController.h"

@interface AppDelegate ()
{
    UIViewController *leftMenuVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LGSideMenuController *container = (LGSideMenuController *)self.window.rootViewController;
    UINavigationController *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
    UIViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
    UINavigationController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"LoginNC"];

    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]boolValue]==YES)
    {
        [container setRootViewController:vc1];
        [container setLeftViewDisabled:FALSE];
        [container setLeftViewController:leftVC];
    }
    else
    {
        [container setRootViewController:vc2];
        [container setLeftViewDisabled:true];
    }
    
    CGFloat screenWidth = 0.0;
    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        screenWidth=[UIScreen mainScreen].bounds.size.height/3;
    }
    else
    {
        screenWidth=[UIScreen mainScreen].bounds.size.width/3;
    }
    container.leftViewWidth = screenWidth *2.4;
    container.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([[defaults valueForKey:@"setpwd"]boolValue] == YES)
    {
        [[VENTouchLock sharedInstance] setKeychainService:@"testService"
                                          keychainAccount:@"testAccount"
                                            touchIDReason:@"Scan your fingerprint to use the app."
                                     passcodeAttemptLimit:500000
                                splashViewControllerClass:[SampleLockSplashViewController class]];
        
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([[defaults valueForKey:@"setpwd"]boolValue] == YES)
    {
        [[VENTouchLock sharedInstance] setKeychainService:@"testService"
                                          keychainAccount:@"testAccount"
                                            touchIDReason:@"Scan your fingerprint to use the app."
                                     passcodeAttemptLimit:5
                                splashViewControllerClass:[SampleLockSplashViewController class]];
        
    }

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([[defaults valueForKey:@"setpwd"]boolValue] == YES)
    {
        [[VENTouchLock sharedInstance] setKeychainService:@"testService"
                                          keychainAccount:@"testAccount"
                                            touchIDReason:@"Scan your fingerprint to use the app."
                                     passcodeAttemptLimit:5
                                splashViewControllerClass:[SampleLockSplashViewController class]];
        
    }

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
