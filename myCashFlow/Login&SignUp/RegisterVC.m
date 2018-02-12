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
    UIDatePicker *datePicker;

}
@end

@implementation RegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Login"];
    

    self.txtAddress.placeholder=[TSLanguageManager localizedString:@"Address"];
    self.txtDOB.placeholder=[TSLanguageManager localizedString:@"DOB"];
    self.txtEmail.placeholder=[TSLanguageManager localizedString:@"Email"];
    self.txtFirstName.placeholder=[TSLanguageManager localizedString:@"First Name"];
    self.txtLastName.placeholder=[TSLanguageManager localizedString:@"Last Name"];
    self.txtPhone.placeholder=[TSLanguageManager localizedString:@"Phone Number"];
    self.txtOccupation.placeholder=[TSLanguageManager localizedString:@"Occupation"];
    self.txtMobile.placeholder=[TSLanguageManager localizedString:@"Mobile Number"];
    self.txtPostal.placeholder=[TSLanguageManager localizedString:@"Postal Code"];
    self.txtNationality.placeholder=[TSLanguageManager localizedString:@"Nationality"];
    self.txtPassword.placeholder=[TSLanguageManager localizedString:@"Password"];
    self.txtRepassword.placeholder=[TSLanguageManager localizedString:@"Confirm Password"];
    self.malelbl.text=[TSLanguageManager localizedString:@"Male"];
    self.femalelbl.text=[TSLanguageManager localizedString:@"Female"];

    [self.btnRegister setTitle:[TSLanguageManager localizedString:@"Register"] forState:UIControlStateNormal];
    [self.btnAlreadyMember setTitle:[TSLanguageManager localizedString:@"Already Member? Login"] forState:UIControlStateNormal];

    self.imgMale.tintColor = THEME_COLOR;
    self.imgFemale.tintColor = [UIColor lightGrayColor];
    self.imgMale.image = [UIImage imageNamed:@"checked"];
    self.imgFemale.image = [UIImage imageNamed:@"unchecked"];
    ismale = YES;
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.txtDOB setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelDate)];
    
    [toolBar setItems:[NSArray arrayWithObjects:cancelBtn,space,doneBtn, nil]];
    [self.txtDOB setInputAccessoryView:toolBar];
    
}

-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd.MM.YYYY"];
    self.txtDOB.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.txtDOB resignFirstResponder];
}
-(void)cancelDate
{
    [self.txtDOB resignFirstResponder];
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
        [self.view endEditing:YES];

        [General startLoader:self.view];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtFirstName.text] forKey:@"Firstname"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtLastName.text] forKey:@"Lastname"];
       // [dic setObject:[NSString stringWithFormat:@"%@",self.txtDOB.text] forKey:@"DOB"];
       /* if (ismale == YES)
        {
            [dic setObject:@"Male" forKey:@"Gender"];
        }
        else
        {
            [dic setObject:@"Female" forKey:@"Gender"];
        }*/
        //[dic setObject:[NSString stringWithFormat:@"%@",self.txtNationality.text] forKey:@"Nationality"];
       // [dic setObject:[NSString stringWithFormat:@"%@",self.txtOccupation.text] forKey:@"Occupation"];
      //  [dic setObject:[NSString stringWithFormat:@"%@",self.txtAddress.text] forKey:@"Address1"];
      //  [dic setObject:[NSString stringWithFormat:@"%@",self.txtPostal.text] forKey:@"postcode"];
      //  [dic setObject:[NSString stringWithFormat:@"%@",self.txtPhone.text] forKey:@"landlineNo"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"Emailid"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtMobile.text] forKey:@"Phoneno"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtPassword.text] forKey:@"Password"];
        
        
        

        APIHandler *api = [[APIHandler alloc]init];
        
        [api userRegister:dic withSuccess:^(id result)
        {
            @try
            {
                NSString *str = @"Herzlichen Glückwunsch, Sie haben sich erfolgreich für die myCashflow App registriert.\n            Sobald die App verfügbar ist, können Sie Ihre MyCashflow App nutzen.";
                [General makeToast:str withToastView:self.view];
                int64_t delayInSeconds = 5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                               {
                                   [self.navigationController popViewControllerAnimated:YES];
                               });
            }
            @catch (NSException *exception)
            {
                [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
                
            }
            [General stopLoader];
            
            
        }
        failure:^(NSURLSessionTask *operation, NSError *error)
        {
            [General stopLoader];

        }];
    }
    
}

-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    
    if(self.txtFirstName.text == NULL || [self.txtFirstName.text isEqualToString:@""])
    {
        [self.txtFirstName showErrorWithText:[TSLanguageManager localizedString:@"Enter Your First Name"]];
        return validation;
    }
    
    else if(self.txtLastName.text == NULL || [self.txtLastName.text isEqualToString:@""])
    {
        [self.txtLastName showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Last Name"]];
        return validation;
    }
    
   /* else if(self.txtDOB.text == NULL || [self.txtDOB.text isEqualToString:@""])
    {
        [self.txtDOB showErrorWithText:[TSLanguageManager localizedString:@"Select Your DOB"]];
        return validation;
    }
    
    else if(self.txtNationality.text == NULL || [self.txtNationality.text isEqualToString:@""])
    {
        [self.txtNationality showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Nationality"]];
        return validation;
    }
    
    else if(self.txtPhone.text == NULL || [self.txtPhone.text isEqualToString:@""])
    {
        [self.txtPhone showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Phone Number"]];
        return validation;
    }
    */
    else if(self.txtMobile.text == NULL || [self.txtMobile.text isEqualToString:@""])
    {
        [self.txtMobile showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Mobile Number"]];
        return validation;
    }
    
   

    
    else if(self.txtEmail.text == NULL || [self.txtEmail.text isEqualToString:@""])
    {
        [self.txtEmail showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Email ID"]];
        return validation;
    }
    
    else if(![self validateEmailWithString:self.txtEmail.text])
    {
        [self.txtEmail showErrorWithText:[TSLanguageManager localizedString:@"Enter Valid Email ID"]];
        return validation;
    }
   
    
    
    else if(self.txtPassword.text == NULL || [self.txtPassword.text isEqualToString:@""])
    {
        [self.txtPassword showErrorWithText:[TSLanguageManager localizedString:@"Enter Password"]];
        return validation;
    }
    
    else if(self.txtRepassword.text == NULL || [self.txtRepassword.text isEqualToString:@""])
    {
        [self.txtRepassword showErrorWithText:[TSLanguageManager localizedString:@"Enter Confirm Password"]];
        return validation;
    }
    
    /*else if(!(self.txtRepassword.text.length >= 6 || self.txtPassword.text.length >= 6))
     {
     [self.txtRepassword showErrorWithText:@"Password Must be at least 6 characters"];
     return validation;
     }*/
    
    else if(![self.txtRepassword.text isEqualToString:self.txtPassword.text])
    {
        [self.txtRepassword showErrorWithText:[TSLanguageManager localizedString:@"Password Mismatch"]];
        return validation;
    }
    /*
    else if(self.txtAddress.text == NULL || [self.txtAddress.text isEqualToString:@""])
    {
        [self.txtAddress showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Address"]];
        return validation;
    }
    else if(self.txtOccupation.text == NULL || [self.txtOccupation.text isEqualToString:@""])
    {
        [self.txtOccupation showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Occupation"]];
        return validation;
    }
    
    else if(self.txtPostal.text == NULL || [self.txtPostal.text isEqualToString:@""])
    {
        [self.txtPostal showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Postal"]];
        return validation;
    }
*/
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
