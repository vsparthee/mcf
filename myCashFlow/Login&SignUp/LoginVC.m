//
//  LoginVC.m
//  myCashFlow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "LoginVC.h"
#import "VENTouchLock.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SampleLockSplashViewController.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Login"];
    self.txtUserName.placeholder=[TSLanguageManager localizedString:@"User Name"];
    self.txtPassword.placeholder=[TSLanguageManager localizedString:@"Password"];
    [self.btnRegister setTitle:[TSLanguageManager localizedString:@"Register"] forState:UIControlStateNormal];
    [self.btnForgot setTitle:[TSLanguageManager localizedString:@"Forgot Password"] forState:UIControlStateNormal];
    [self.btnLogin setTitle:[TSLanguageManager localizedString:@"Login"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    /********/
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    if ([[userDefaults valueForKey:@"setpwd"]boolValue] == YES)
    {
        [General stopLoader];
        
        [[VENTouchLock sharedInstance] setKeychainService:@"myCashFlow"
                                          keychainAccount:@"myCashFlow"
                                            touchIDReason:@"Scan your fingerprint to use the app."
                                     passcodeAttemptLimit:500000
                                splashViewControllerClass:[SampleLockSplashViewController class]];
        [userDefaults setBool:TRUE forKey:@"isLogin"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LGSideMenuController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LGSideMenuController"];
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
        UIViewController *leftMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
        [rootViewController setRootViewController:homeVC];
        [rootViewController setLeftViewController:leftMenuVC];
        [rootViewController setLeftViewDisabled:FALSE];
        CGFloat screenWidth = 0.0;
        if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
        {
            screenWidth=[UIScreen mainScreen].bounds.size.height/3;
        }
        else
        {
            screenWidth=[UIScreen mainScreen].bounds.size.width/3;
        }
        rootViewController.leftViewWidth = screenWidth *2.4;
        
        rootViewController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
        [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
        
   
    }
   
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)action_Login:(UIButton *)sender
{
    if ([self validateRequest])
    {
        [self.view endEditing:YES];
        [General startLoader:self.view];

        NSString *pushNotiToken = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"FIREBASE_TOKEN"]];
        
        NSMutableDictionary *userdic = [[NSMutableDictionary alloc]init];
        
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtUserName.text] forKey:@"Username"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtPassword.text] forKey:@"Password"];
        [userdic setObject:pushNotiToken forKey:@"DeviceKey"];

        
        APIHandler *api = [[APIHandler alloc]init];
        [api userLogin:userdic withSuccess:^(id result)
         {
             @try
             {
                 if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
                 {
                     [[VENTouchLock sharedInstance] setKeychainService:@"myCashFlow"
                                                       keychainAccount:@"myCashFlow"
                                                         touchIDReason:@"Scan your fingerprint to use the app."
                                                  passcodeAttemptLimit:500000
                                             splashViewControllerClass:[SampleLockSplashViewController class]];
                     
                     NSMutableDictionary *dic=[result valueForKey:@"data"];
                     
                     NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                     
                     [userDefaults setValue:[self CheckDictionary:[dic mutableCopy]] forKey:@"userInfo"];
                     
                     [userDefaults setValue:[NSString stringWithFormat:@"%@",_txtPassword.text] forKey:@"password"];
                     
                    LAContext *context = [[LAContext alloc] init];
                      NSError *error = nil;
                      NSString *reason = [TSLanguageManager localizedString:@"Please authenticate using TouchID."];
                      
                      if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                      [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                      localizedReason:reason
                      reply:^(BOOL success, NSError *error) {
                      if (success) {
                         // [[VENTouchLock sharedInstance] deletePasscode];

                      [self setPasscode];
                      }
                      else {
                      NSLog(@"Error received: %@", error);
                      [General stopLoader];
                      
                      }
                      }];
                      }
                      else
                      {

                      [self setPasscode];
                      }
                     
                     
                     [userDefaults setBool:TRUE forKey:@"isLogin"];
                     
                     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                     LGSideMenuController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LGSideMenuController"];
                     UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
                     UIViewController *leftMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
                     [rootViewController setRootViewController:homeVC];
                     [rootViewController setLeftViewController:leftMenuVC];
                     [rootViewController setLeftViewDisabled:FALSE];
                     CGFloat screenWidth = 0.0;
                     if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
                     {
                         screenWidth=[UIScreen mainScreen].bounds.size.height/3;
                     }
                     else
                     {
                         screenWidth=[UIScreen mainScreen].bounds.size.width/3;
                     }
                     rootViewController.leftViewWidth = screenWidth *2.4;
                     
                     rootViewController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
                     [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
                     
                     
                     
                 }
                 else
                 {
                     [General makeToast:[result valueForKey:@"status"] withToastView:self.view];
                     [General stopLoader];
                     
                 }
             }
             @catch (NSException *exception)
             {
                 [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
                 
             }
             [General stopLoader];
            
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             [General stopLoader];

         }];
    }
}

-(NSMutableDictionary*)CheckDictionary:(NSMutableDictionary *)dic
{
    NSArray *Arr = [dic allKeys];
    for (int i = 0; i<Arr.count; i++)
    {
        if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSNull class]])
        {
            [dic setObject:@"" forKey:[Arr objectAtIndex:i]];
        }
        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dict = [[dic valueForKey:[Arr objectAtIndex:i]] mutableCopy];
            [dic setObject:dict forKey:[Arr objectAtIndex:i]];
            [self CheckDictionary:dict];
        }
        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSMutableArray class]])
        {
            NSMutableArray *Arr12 = [dic valueForKey:[Arr objectAtIndex:i]];
            for (int j = 0; j<Arr12.count; j++)
            {
                if ([[Arr12 objectAtIndex:j] isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *dict123 = [Arr12 objectAtIndex:j];
                    NSLog(@"dict123 : %@",dict123);
                    NSMutableDictionary *dict = [dict123 mutableCopy];
                    NSLog(@"dict123 Mutable copy : %@",dict);
                    [Arr12 replaceObjectAtIndex:j withObject:dict];
                    NSLog(@"dict123 replace : %@",[Arr12 objectAtIndex:j]);
                    [self CheckDictionary:dict];
                }
            }
        }
    }
    NSLog(@"Dic:%@",dic);
    return dic;
}

-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    if(self.txtUserName.text == NULL || [self.txtUserName.text isEqualToString:@""])
    {
        [self.txtUserName showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Email ID"]];
        return validation;
    }
    
    else if(![self validateEmailWithString:self.txtUserName.text])
    {
        [self.txtUserName showErrorWithText:[TSLanguageManager localizedString:@"Enter Valid Email ID"]];
        return validation;
    }
    else if(self.txtPassword.text == NULL || [self.txtPassword.text isEqualToString:@""])
    {
        [self.txtPassword showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Password"]];
        return validation;
    }
    else
    {
        validation = true;
        return validation;
    }
    return validation;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)setPasscode
{
    if ([[VENTouchLock sharedInstance] isPasscodeSet])
    {
        [[VENTouchLock sharedInstance] deletePasscode];
   }
    

    [VENTouchLock setShouldUseTouchID:YES];
    
    VENTouchLockCreatePasscodeViewController *createPasscodeVC = [[VENTouchLockCreatePasscodeViewController alloc] init];
    [self presentViewController:[createPasscodeVC embeddedInNavigationController] animated:YES completion:nil];
}

- (IBAction)action_Forget:(UIButton *)sender {
}

- (IBAction)action_Register:(UIButton *)sender {
}
@end
