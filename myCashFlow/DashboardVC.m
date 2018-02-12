//
//  DashboardVC.m
//  myCashflow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "DashboardVC.h"
#import "VENTouchLock.h"
#import "SampleLockSplashViewController.h"
#import "PopoverView.h"

@interface DashboardVC ()
{
    float height;
    PopoverView *popoverView;
    NSMutableArray *notificationArr;
}
@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        height=[UIScreen mainScreen].bounds.size.width;
    }
    else
    {
        height=[UIScreen mainScreen].bounds.size.height;
    }
    self.viewHeight.constant=height-64;

    float tempHeight=height-64;
    tempHeight=(tempHeight/9)*4-69;
    
    self.imgProfile.layer.cornerRadius=tempHeight/2;
    
    self.imgProfile.clipsToBounds=YES;

    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    
    self.lblProfileTitle.text = [NSString stringWithFormat:@"%@ %@",[userInfo valueForKey:@"Firstname"],[userInfo valueForKey:@"Lastname"]];
    _lblAcc.text = [TSLanguageManager localizedString:@"Accident Reporting"];
    _lblnum.text = [TSLanguageManager localizedString:@"Numbers"];
    _lbloffer.text = [TSLanguageManager localizedString:@"Offers"];
    _lbltax.text = [TSLanguageManager localizedString:@"Tax Folder"];
    _lblappoint.text = [TSLanguageManager localizedString:@"Make an Appointment"];
    _lblfinance.text = [TSLanguageManager localizedString:@"Finance Folder"];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
   /* NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"];
    if (imageData.length>10)
    {
        self.imgProfile.image = [UIImage imageWithData:imageData];
    }
*/
    
    self.btnNotification.alpha=0.6;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //    if ([[defaults valueForKey:@"setpwd"]boolValue] == YES)
    //    {
    //        [[VENTouchLock sharedInstance] setKeychainService:@"myCashflowService"
    //                                          keychainAccount:@"myCashflowAccount"
    //                                            touchIDReason:@"Scan your fingerprint to use the app."
    //                                     passcodeAttemptLimit:500000
    //                                splashViewControllerClass:[SampleLockSplashViewController class]];
    //
    //    }
    
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    [[SDImageCache sharedImageCache] removeImageForKey:[userInfo valueForKey:@"ProfilePic"] fromDisk:YES];
    [self.imgProfile sd_setImageWithURL:[userInfo valueForKey:@"ProfilePic"] placeholderImage:[UIImage imageNamed:@"Consultor Image 384_384.PNG"] options:SDWebImageRefreshCached];
    
    
    
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_GetNotification:^(id result)
     {
         @try
         {
             notificationArr=[result valueForKey:@"data"];
             if (notificationArr.count>0)
             {
                 self.lblCount.hidden=NO;
                 int count=0;
                 for (NSDictionary *dic in notificationArr)
                 {
                     count +=[[dic valueForKey:@"FileUpdateCount"] intValue];
                 }
                 self.lblCount.text=[NSString stringWithFormat:@"%d",count];
                 self.btnNotification.alpha=1;
                 
             }
             else
             {
                 self.lblCount.hidden=YES;
                 self.btnNotification.alpha=0.6;
             }
             
         }
         @catch (NSException *exception)
         {
             // [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         
     }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuAction:(id)sender
{
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}


- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [popoverView hide];
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.viewHeight.constant=height;
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.viewHeight.constant=height-64;

    }
}


- (IBAction)action_Notification:(UIButton *)sender
{
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in notificationArr)
    {
        if (!([[dic valueForKey:@"NotifcationName"]rangeOfString:@"video" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            NSString *str;
            if ([[dic valueForKey:@"FileUpdateCount"] intValue]>1)
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
               
            }
            else
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];

            }
            PopoverAction *action1 = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action)
            {
                [self performSegueWithIdentifier:@"dashboard_to_video" sender:self];
                
            }];
            [arr addObject:action1];
        }
        if (!([[dic valueForKey:@"NotifcationName"]rangeOfString:@"message" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            NSString *str;
            if ([[dic valueForKey:@"FileUpdateCount"] intValue]>1)
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            else
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            PopoverAction *action2 = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action)
                                      {
                                          [self performSegueWithIdentifier:@"dashboard_to_msg" sender:self];
                                          
                                      }];

            [arr addObject:action2];
        }
        if (!([[dic valueForKey:@"NotifcationName"]rangeOfString:@"discount" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            NSString *str;
            if ([[dic valueForKey:@"FileUpdateCount"] intValue]>1)
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            else
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            PopoverAction *action3 = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action)
                                      {
                                          [self performSegueWithIdentifier:@"dashboard_to_offer" sender:self];
                                          
                                      }];

            [arr addObject:action3];
        }
        if (!([[dic valueForKey:@"NotifcationName"]rangeOfString:@"document" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            NSString *str;
            if ([[dic valueForKey:@"FileUpdateCount"] intValue]>1)
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            else
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            PopoverAction *action4 = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action)
                                      {
                                          [self performSegueWithIdentifier:@"dashboard_to_doc" sender:self];
                                          
                                      }];

            [arr addObject:action4];
        }
        if (!([[dic valueForKey:@"NotifcationName"]rangeOfString:@"solution" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            NSString *str;
            if ([[dic valueForKey:@"FileUpdateCount"] intValue]>1)
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            else
            {
                str=[NSString stringWithFormat:@"%@ new %@",[dic valueForKey:@"FileUpdateCount"],[dic valueForKey:@"NotifcationName"]];
                
            }
            PopoverAction *action5 = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action)
                                      {
                                          [self performSegueWithIdentifier:@"dashboard_to_solution" sender:self];
                                          
                                      }];
            
            [arr addObject:action5];
        }

        
    }
    if (notificationArr.count>0)
    {
        NSArray *temp=arr;
        popoverView = [PopoverView popoverView];
        popoverView.style = PopoverViewStyleDefault;
        [popoverView showToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width-61, 54) withActions:temp];

    }
}
@end
