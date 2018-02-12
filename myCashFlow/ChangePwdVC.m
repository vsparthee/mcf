//
//  ChangePwdVC.m
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ChangePwdVC.h"

@interface ChangePwdVC ()<UITextFieldDelegate>

@end

@implementation ChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Change Password"];

    self.txtnewpwd.placeholder=[TSLanguageManager localizedString:@"New Password"];
    self.txtoldpwd.placeholder=[TSLanguageManager localizedString:@"Old Password"];
    self.txtconfirmpwd.placeholder=[TSLanguageManager localizedString:@"Confirm Password"];
    [self.btnchange setTitle:[TSLanguageManager localizedString:@"Change Password"] forState:UIControlStateNormal];
    
    self.txtconfirmpwd.delegate=self;
    self.txtnewpwd.delegate=self;
    self.txtoldpwd.delegate=self;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)action_Menu:(UIButton *)sender
{
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (IBAction)action_Back:(UIButton *)sender
{
    if( [self navigationController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)action_ChangePwd:(UIButton *)sender
{
    if ([self validateRequest])
    {
        [General startLoader:self.view];
        [sender setUserInteractionEnabled:NO];
        NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
        NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
        [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtconfirmpwd.text] forKey:@"newpassword"];
        
        
        
        
        
 APIHandler *api = [[APIHandler alloc]init];
        
        [api api_ChangePassword:apiDic withSuccess:^(id result)
        {
            @try
            {
                if ([[result valueForKey:@"status"] boolValue]==true)
                {
                    [General makeToast:[TSLanguageManager localizedString:@"Password changed Successfully"] withToastView:self.view];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",_txtconfirmpwd.text] forKey:@"password"];
                    int64_t delayInSeconds = 3;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                                   {
                                       [General stopLoader];
                                       [sender setUserInteractionEnabled:YES];
                                       
                                       if( [self navigationController])
                                       {
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }
                                       else
                                       {
                                           [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
                                       }
                                   });
                }
                else
                {
                    [sender setUserInteractionEnabled:YES];
                    [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
                    [General stopLoader];
                }
            }
            @catch (NSException *exception)
            {
                [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
                [General stopLoader];

                
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [sender setUserInteractionEnabled:YES];
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
            [General stopLoader];
        }];
    }
}


-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSLog(@"txtNewPwd:%@, _txtConfirmPwd:%@",self.txtnewpwd.text,_txtconfirmpwd.text);
    
    
    if(self.txtoldpwd.text == NULL || [self.txtoldpwd.text isEqualToString:@""])
    {
        [self.txtoldpwd showErrorWithText:[TSLanguageManager localizedString:@"Enter Current Password"]];
        return validation;
    }
    else if(self.txtnewpwd.text == NULL || [self.txtnewpwd.text isEqualToString:@""])
    {
        [self.txtnewpwd showErrorWithText:[TSLanguageManager localizedString:@"Enter New Password"]];

        return validation;
    }
    else if(self.txtconfirmpwd.text == NULL || [self.txtconfirmpwd.text isEqualToString:@""])
    {
        [self.txtconfirmpwd showErrorWithText:[TSLanguageManager localizedString:@"Enter Confirm Password"]];

        return validation;
    }
    
    
    else if(![self.txtnewpwd.text isEqualToString:self.txtconfirmpwd.text])
    {
        [self.txtnewpwd showErrorWithText:[TSLanguageManager localizedString:@"Password Mismatch"]];
        [self.txtconfirmpwd showErrorWithText:[TSLanguageManager localizedString:@"Password Mismatch"]];

        return validation;
    }
    else if([self.txtoldpwd.text isEqualToString:[userdefault valueForKey:@"password"]])
    {
        [self.txtoldpwd showErrorWithText:[TSLanguageManager localizedString:@"Invalid Old Password"]];

        return validation;
    }
    else if([self.txtoldpwd.text isEqualToString:self.txtconfirmpwd.text])
    {
        [self.txtoldpwd showErrorWithText:[TSLanguageManager localizedString:@"Mismatch Current And New Password"]];
        return validation;
    }
    else{
        
        validation = true;
        return validation;
    }
    return validation;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
