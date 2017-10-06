//
//  RegisterVC.m
//  myCashFlow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "RegisterVC.h"
#import "Constant.h"
@interface RegisterVC ()
{
    BOOL ismale;
}
@end

@implementation RegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imgMale.tintColor = THEME_COLOR;
    self.imgFemale.tintColor = [UIColor lightGrayColor];
    self.imgMale.image = [UIImage imageNamed:@"checked"];
    self.imgFemale.image = [UIImage imageNamed:@"unchecked"];
    ismale = YES;
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)action_Already_Member:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)action_Register:(UIButton *)sender
{
    if ([self validateRequest])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtFirstName.text] forKey:@"Firstname"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtLastName.text] forKey:@"Lastname"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtDOB.text] forKey:@"DOB"];
        if (ismale == YES)
        {
            [dic setObject:@"Male" forKey:@"Gender"];
        }
        else
        {
            [dic setObject:@"Female" forKey:@"Gender"];
        }
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtNationality.text] forKey:@"Nationality"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtOccupation.text] forKey:@"Occupation"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtAddress.text] forKey:@"Address"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtPostal.text] forKey:@"postcode"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtPhone.text] forKey:@"landlineNo"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"Emailid"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtMobile.text] forKey:@"Phoneno"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtPassword.text] forKey:@"Password"];
        
        APIHandler *api = [[APIHandler alloc]init];
        
        [api userRegister:dic withSuccess:^(id result)
        {
            [self.navigationController popViewControllerAnimated:YES];

        }
        failure:^(NSURLSessionTask *operation, NSError *error)
        {
            
        }];
    }
    
}

-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    
    if(self.txtFirstName.text == NULL || [self.txtFirstName.text isEqualToString:@""])
    {
        [self.txtFirstName showErrorWithText:@"Enter Your First Name"];
        return validation;
    }
    
    else if(self.txtLastName.text == NULL || [self.txtLastName.text isEqualToString:@""])
    {
        [self.txtLastName showErrorWithText:@"Enter Your Last Name"];
        return validation;
    }
    
    else if(self.txtDOB.text == NULL || [self.txtDOB.text isEqualToString:@""])
    {
        [self.txtDOB showErrorWithText:@"Select Your DOB"];
        return validation;
    }
    
    else if(self.txtNationality.text == NULL || [self.txtNationality.text isEqualToString:@""])
    {
        [self.txtNationality showErrorWithText:@"Enter Your Nationality"];
        return validation;
    }
    
    else if(self.txtOccupation.text == NULL || [self.txtOccupation.text isEqualToString:@""])
    {
        [self.txtOccupation showErrorWithText:@"Enter Your Occupation"];
        return validation;
    }

    
    else if(self.txtEmail.text == NULL || [self.txtEmail.text isEqualToString:@""])
    {
        [self.txtEmail showErrorWithText:@"Enter Your Email ID"];
        return validation;
    }
    
    else if(![self validateEmailWithString:self.txtEmail.text])
    {
        [self.txtEmail showErrorWithText:@"Enter Valid Email ID"];
        return validation;
    }
   
    else if(self.txtPhone.text == NULL || [self.txtPhone.text isEqualToString:@""])
    {
        [self.txtPhone showErrorWithText:@"Enter Your Phone Number"];
        return validation;
    }
    
    else if(self.txtMobile.text == NULL || [self.txtMobile.text isEqualToString:@""])
    {
        [self.txtMobile showErrorWithText:@"Enter Your Mobile Number"];
        return validation;
    }
    
    else if(self.txtPostal.text == NULL || [self.txtPostal.text isEqualToString:@""])
    {
        [self.txtPostal showErrorWithText:@"Enter Your Postal"];
        return validation;
    }
    
    
    else if(self.txtPassword.text == NULL || [self.txtPassword.text isEqualToString:@""])
    {
        [self.txtPassword showErrorWithText:@"Enter Password"];
        return validation;
    }
    
    else if(self.txtRepassword.text == NULL || [self.txtRepassword.text isEqualToString:@""])
    {
        [self.txtRepassword showErrorWithText:@"Enter Confirm Password"];
        return validation;
    }
    
    /*else if(!(self.txtRepassword.text.length >= 6 || self.txtPassword.text.length >= 6))
     {
     [self.txtRepassword showErrorWithText:@"Password Must be at least 6 characters"];
     return validation;
     }*/
    
    else if(![self.txtRepassword.text isEqualToString:self.txtPassword.text])
    {
        [self.txtRepassword showErrorWithText:@"Password Mismatch"];
        return validation;
    }
    
    else if(self.txtAddress.text == NULL || [self.txtAddress.text isEqualToString:@""])
    {
        [self.txtAddress showErrorWithText:@"Enter Your Address"];
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




- (IBAction)action_EditImage:(UIButton *)sender
{
    
}
- (IBAction)action_Male:(UIButton *)sender
{
    self.imgMale.tintColor = THEME_COLOR;
    self.imgFemale.tintColor = [UIColor lightGrayColor];
    self.imgMale.image = [UIImage imageNamed:@"checked"];
    self.imgFemale.image = [UIImage imageNamed:@"unchecked"];
    ismale = YES;
}
- (IBAction)action_Female:(UIButton *)sender
{
    self.imgMale.tintColor = [UIColor lightGrayColor];
    self.imgFemale.tintColor = THEME_COLOR;
    self.imgMale.image = [UIImage imageNamed:@"unchecked"];
    self.imgFemale.image = [UIImage imageNamed:@"checked"];
    ismale = NO;
}

@end
