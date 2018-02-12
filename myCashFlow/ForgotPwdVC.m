//
//  ForgotPwdVC.m
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ForgotPwdVC.h"

@interface ForgotPwdVC ()

@end

@implementation ForgotPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnCancel setTitle:[TSLanguageManager localizedString:@"Cancel"] forState:UIControlStateNormal];
    [self.btnForgot setTitle:[TSLanguageManager localizedString:@"Get Password"] forState:UIControlStateNormal];
    self.txtEmail.placeholder=[TSLanguageManager localizedString:@"User Name"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)action_Cancel:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)action_Forgot:(UIButton *)sender
{
    if ([self validateRequest])
    {
        [General startLoader:self.view];
        [sender setUserInteractionEnabled:NO];

        NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
        [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"emailID"];
        
        
        
        
        
 APIHandler *api = [[APIHandler alloc]init];
        [api api_ForgetPassword:apiDic withSuccess:^(id result)
        {
            @try
            {
                if ([[result valueForKey:@"status"] boolValue]==true)
                {
                    [General makeToast:[result valueForKey:@"Message"] withToastView:self.view];
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
                
            }
         
        }
        failure:^(NSURLSessionTask *operation, NSError *error)
        {
            [sender setUserInteractionEnabled:YES];
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
            [General stopLoader];
        }];
    }
}

-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    if(self.txtEmail.text == NULL || [self.txtEmail.text isEqualToString:@""])
    {
        [self.txtEmail showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Email ID"]];
        return validation;
    }
    
    else if(![self validateEmailWithString:self.txtEmail.text])
    {
        [self.txtEmail showErrorWithText:[TSLanguageManager localizedString:@"Enter Valid Email ID"]];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
