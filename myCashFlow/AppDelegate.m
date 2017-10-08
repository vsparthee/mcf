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
@import UIKit;
@import Firebase;
@import UserNotifications;
@import UserNotificationsUI;
FCAlertView *alert;
@interface AppDelegate ()<FCAlertViewDelegate>
{
    UIViewController *leftMenuVC;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [FIRApp configure];

    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    NSLog(@"FCM registration token: %@", fcmToken);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LGSideMenuController *container = (LGSideMenuController *)self.window.rootViewController;
    UINavigationController *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
    leftMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
    UINavigationController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"LoginNC"];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    /*[defaults setBool:TRUE forKey:@"isLogin"];

    NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
    [temp setObject:[NSNumber numberWithInt:4]  forKey:@"CustomerID"];
    [defaults setValue:temp forKey:@"userInfo"];*/
    
    if ([[defaults valueForKey:@"isLogin"]boolValue]==YES)
    {
        [container setRootViewController:vc1];
        [container setLeftViewDisabled:FALSE];
        [container setLeftViewController:leftMenuVC];
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
    container.leftViewPresentationStyle = LGSideMenuPresentationStyleScaleFromBig;
   /*
    LGSideMenuPresentationStyleSlideBelow      = 1,
    LGSideMenuPresentationStyleScaleFromBig    = 2,
    LGSideMenuPresentationStyleScaleFromLittle = 3

    */
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

- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSLog(@"FCM registration token: %@", fcmToken);
    
    // TODO: If necessary send token to application server.
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
   
    [FIRMessaging messaging].APNSToken = deviceToken;

}



- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#if !TARGET_IPHONE_SIMULATOR
#endif
}

// With "FirebaseAppDelegateProxyEnabled": NO

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UIApplicationState state = [application applicationState];
    
    if (state == UIApplicationStateActive) {
        
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        
        if([message isKindOfClass:[NSString class]] == YES)
        {
            [self showAlert:message];
        }
        else if ([message isKindOfClass:[NSDictionary class]] == YES)
        {
            NSString *bodyStr =[NSString stringWithFormat:@"%@",[[userInfo valueForKey:@"aps"] valueForKeyPath:@"alert.body"]];
            NSString *titleStr =[NSString stringWithFormat:@"%@",[[userInfo valueForKey:@"aps"] valueForKeyPath:@"alert.title"]];
            message =[NSString stringWithFormat:@"%@ \n %@",titleStr,bodyStr] ;
            [self showAlert:message];
        }
        
    }
    else
    {
        [(LeftMenuVC*)leftMenuVC selectrow:6 withTag:0 withData:@"test"];
    }


}


-(void)showAlert : (NSString *)msg
{
    
    
    NSString *message = msg;
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    alert.titleFont = [UIFont fontWithName:@"CenturyGothic-Bold" size:16];
    alert.subtitleFont = [UIFont fontWithName:@"CenturyGothic" size:15];
    alert.firstButtonBackgroundColor = THEME_COLOR;
    alert.secondButtonBackgroundColor = DARK_BG;
    alert.delegate = self;
    alert.bounceAnimations = YES;
    alert.hideDoneButton = YES;
    alert.customImageScale = 1.1;
    alert.titleColor = [UIColor darkGrayColor];
    alert.subTitleColor = [UIColor darkGrayColor];
    alert.firstButtonTitleColor = [UIColor whiteColor];
    alert.secondButtonTitleColor = [UIColor whiteColor];
    alert.colorScheme = DARK_BG;
    alert.avoidCustomImageTint = 0;
    
    
    [alert showAlertInView:self.window.rootViewController
                 withTitle:@"myCashFlow"
              withSubtitle:message
           withCustomImage:[UIImage imageNamed:@"Logo 510_300.PNG"]
       withDoneButtonTitle:nil
                andButtons:@[@"Open", @"Close"]];

    
}

- (void) FCAlertView:(FCAlertView *)alertView clickedButtonIndex:(NSInteger)index buttonTitle:(NSString *)title {
    if ([title isEqualToString:@"Close"])
    {
    }
    if ([title isEqualToString:@"Open"])
    {
        [(LeftMenuVC*)leftMenuVC selectrow:6 withTag:0 withData:@"test"];

    }
}



@end
