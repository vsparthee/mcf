//
//  UserProfileVC.m
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "UserProfileVC.h"

@interface UserProfileVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSString *base64Str;
    UIDatePicker *datePicker;
    BOOL ismale;
    NSData *data;

}
@end

@implementation UserProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = nil;
    
    self.lbltitle.text=[TSLanguageManager localizedString:@"My Account"];
    self.malelbl.text=[TSLanguageManager localizedString:@"Male"];
    self.femalelbl.text=[TSLanguageManager localizedString:@"Female"];
    [self.btnUpdate setTitle:[TSLanguageManager localizedString:@"Update Profile"] forState:UIControlStateNormal];
    
    self.txtAddress.placeholder=[TSLanguageManager localizedString:@"Address"];
    self.txtDOB.placeholder=[TSLanguageManager localizedString:@"DOB"];
    self.txtEmail.placeholder=[TSLanguageManager localizedString:@"Email"];
    self.txtFirstName.placeholder=[TSLanguageManager localizedString:@"First Name"];
    self.txtLastName.placeholder=[TSLanguageManager localizedString:@"Last Name"];
    self.txtPhone.placeholder=[TSLanguageManager localizedString:@"Landline Number"];
    self.txtOccupation.placeholder=[TSLanguageManager localizedString:@"Occupation"];
    self.txtMobile.placeholder=[TSLanguageManager localizedString:@"Mobile Number"];
    self.txtPostal.placeholder=[TSLanguageManager localizedString:@"Postal Code"];
    self.txtNationality.placeholder=[TSLanguageManager localizedString:@"Nationality"];
    self.txtxCity.placeholder=[TSLanguageManager localizedString:@"City/Village"];
    self.txtSecEmail.placeholder=[TSLanguageManager localizedString:@"Secondary Email"];

    self.txtEmail.userInteractionEnabled=NO;

    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    if ([[userInfo valueForKey:@"Gender"]isEqualToString:@"male"]||[[userInfo valueForKey:@"Gender"]isEqualToString:@"Male"])
    {
        self.imgMale.tintColor = THEME_COLOR;
        self.imgFemale.tintColor = [UIColor lightGrayColor];
        self.imgMale.image = [UIImage imageNamed:@"checked"];
        self.imgFemale.image = [UIImage imageNamed:@"unchecked"];
        ismale = YES;
    }
    else
    {
        self.imgMale.tintColor = [UIColor lightGrayColor];
        self.imgFemale.tintColor = THEME_COLOR;
        self.imgMale.image = [UIImage imageNamed:@"unchecked"];
        self.imgFemale.image = [UIImage imageNamed:@"checked"];
        ismale = NO;
    }
    
    self.txtAddress.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Address1"]];
    self.txtDOB.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"DOB"]];
    self.txtEmail.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Emailid"]];
    self.txtFirstName.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Firstname"]];
    self.txtLastName.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Lastname"]];
    self.txtPhone.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"landlineNo"]];
    self.txtOccupation.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Occupation"]];
    self.txtMobile.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Phoneno"]];
    self.txtPostal.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"postcode"]];
    self.txtxCity.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Address2"]];
   // self.txtSecEmail.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"sec_email_id"]];

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
    NSDictionary *userInfodic = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [[SDImageCache sharedImageCache] removeImageForKey:[userInfodic valueForKey:@"ProfilePic"] fromDisk:YES];

    [self.imgProfile sd_setImageWithURL:[userInfodic valueForKey:@"ProfilePic"] placeholderImage:[UIImage imageNamed:@"Consultor Image 384_384.PNG"] options:SDWebImageRefreshCached];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.settingView.hidden=YES;
    
    if( [self navigationController]||[self presentingViewController])
    {
        self.btnMenu.hidden=YES;
    }
    else
    {
        self.btnMenu.hidden=NO;
    }
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
        [self.parent home];
    }
}


- (IBAction)action_EditImage:(UIButton *)sender
{
    [self changePhoto];
}

- (IBAction)action_Setting:(UIButton *)sender
{
   // [[IQKeyboardManager sharedManager] resignFirstResponder];

}
- (IBAction)action_ChangePwd:(UIButton *)sender {
}

- (IBAction)action_ChangePin:(UIButton *)sender {
}

- (IBAction)action_ChangeLang:(UIButton *)sender {
}

- (IBAction)action_SignOut:(UIButton *)sender {
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
    
    else if(self.txtDOB.text == NULL || [self.txtDOB.text isEqualToString:@""])
    {
        [self.txtDOB showErrorWithText:[TSLanguageManager localizedString:@"Select Your DOB"]];
        return validation;
    }
    else if(self.txtOccupation.text == NULL || [self.txtOccupation.text isEqualToString:@""])
    {
        [self.txtOccupation showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Occupation"]];
        return validation;
    }

    else if(self.txtSecEmail.text.length>3&&![self validateEmailWithString:self.txtSecEmail.text])
    {
        [self.txtSecEmail showErrorWithText:[TSLanguageManager localizedString:@"Enter Valid Email ID"]];
        return validation;
    }
    
    
    else if(self.txtPhone.text == NULL || [self.txtPhone.text isEqualToString:@""])
    {
        [self.txtPhone showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Landline Number"]];
        return validation;
    }
    
    else if(self.txtMobile.text == NULL || [self.txtMobile.text isEqualToString:@""])
    {
        [self.txtMobile showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Mobile Number"]];
        return validation;
    }
    
    else if(self.txtPostal.text == NULL || [self.txtPostal.text isEqualToString:@""])
    {
        [self.txtPostal showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Postal"]];
        return validation;
    }
    
    else if(self.txtAddress.text == NULL || [self.txtAddress.text isEqualToString:@""])
    {
        [self.txtAddress showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Address"]];
        return validation;
    }
    
    
    else if(self.txtxCity.text == NULL || [self.txtxCity.text isEqualToString:@""])
    {
        [self.txtxCity showErrorWithText:[TSLanguageManager localizedString:@"Enter Your Postal"]];
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
- (IBAction)action_upt:(id)sender
{
    if ([self validateRequest])
    {
        [General startLoader:self.view];

        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        
        [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"customer_id"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtFirstName.text] forKey:@"firstname"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtLastName.text] forKey:@"lastname"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtDOB.text] forKey:@"dob"];
        if (ismale == YES)
        {
            [dic setObject:@"Male" forKey:@"gender"];
        }
        else
        {
            [dic setObject:@"Female" forKey:@"gender"];
        }
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtOccupation.text] forKey:@"occupation"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtAddress.text] forKey:@"address1"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtPostal.text] forKey:@"postcode"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtPhone.text] forKey:@"tele_no"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"pri_email_id"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtMobile.text] forKey:@"mobile"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtxCity.text] forKey:@"address2"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtSecEmail.text] forKey:@"sec_email_id"];
        [dic setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]] forKey:@"password"];
        [dic setObject:@"" forKey:@"age"];

        
        NSMutableDictionary *userdic = [[NSMutableDictionary alloc]init];
        [userdic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
        [userdic setValue:[userInfo valueForKey:@"ID"] forKey:@"ID"];
        [userdic setValue:[userInfo valueForKey:@"ConsultantID"] forKey:@"ConsultantID"];
        [userdic setValue:[userInfo valueForKey:@"ConsultantName"] forKey:@"ConsultantName"];

        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtFirstName.text] forKey:@"Firstname"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtLastName.text] forKey:@"Lastname"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtDOB.text] forKey:@"DOB"];
        if (ismale == YES)
        {
            [userdic setObject:@"Male" forKey:@"Gender"];
        }
        else
        {
            [userdic setObject:@"Female" forKey:@"Gender"];
        }
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtOccupation.text] forKey:@"Occupation"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtAddress.text] forKey:@"Address1"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtPostal.text] forKey:@"postcode"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtPhone.text] forKey:@"landlineNo"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"Emailid"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtMobile.text] forKey:@"Phoneno"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtxCity.text] forKey:@"Address2"];
        [userdic setObject:[NSString stringWithFormat:@"%@",self.txtSecEmail.text] forKey:@"sec_email_id"];
        [userdic setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]] forKey:@"Password"];
        [userdic setObject:@"" forKey:@"age"];
        NSDictionary *userInfodic = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        [userdic setObject:[userInfodic valueForKey:@"ProfilePic"] forKey:@"ProfilePic"];


        
        
      /*  APIHandler *api = [[APIHandler alloc]init];
        
        [api api_ProfileUpdate:dic withSuccess:^(id result)
         {
             @try
             {
                 if ([[result valueForKey:@"status"] isEqualToString:@"Success"])
                 {
                     NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                     
                     [userDefaults setValue:[self CheckDictionary:[userdic mutableCopy]] forKey:@"userInfo"];
                     [General makeToast:[TSLanguageManager localizedString:@"Profile Successfully updated"] withToastView:self.view];


                 }
                 else
                 {
                     [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
                 }

             }
             @catch (NSException *exception)
             {
                 [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
                 
             }
             [General stopLoader];
             
             //[self.navigationController popViewControllerAnimated:YES];
             
         }
                  failure:^(NSURLSessionTask *operation, NSError *error)
         {
             [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.baseview];
             [General stopLoader];

         }];
       */
        NSString * url = [NSString stringWithFormat:API_ProfileUpdate,BASE_URL];

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (data!=nil)
            {
                NSString *filename = [NSString stringWithFormat:@"%@.jpeg",[userInfodic valueForKey:@"ID"]];
                [formData appendPartWithFileData:data
                                            name:@"Profilepic"
                                        fileName:filename mimeType:@"image/jpeg"];
            }
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
         {
             @try
             {
                 if ([[responseObject valueForKey:@"status"] isEqualToString:@"Success"])
                 {
                     NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                     
                     [userDefaults setValue:[self CheckDictionary:[userdic mutableCopy]] forKey:@"userInfo"];
                     [General makeToast:[TSLanguageManager localizedString:@"Profile Successfully updated"] withToastView:self.view];
                     data = nil;
                     
                 }
                 else
                 {
                     [General makeToast:@"Something went wrong. Please try again later" withToastView:self.view];
                 }
                 [General stopLoader];
             }
             @catch (NSException *exception)
             {
                 [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error)
         {
             [General makeToast:@"Something went wrong. Please try again later" withToastView:self.view];
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
- (void)changePhoto{
    
    NSLog(@"Inside Image Change...");
    UIActionSheet  *webSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLocalizedString([TSLanguageManager localizedString:@"Cancel"], nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString([TSLanguageManager localizedString:@"Albums"], nil),NSLocalizedString([TSLanguageManager localizedString:@"Take a Photo"], nil), nil];
    [webSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate   = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
        
    } else if (buttonIndex == 1) {
        BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate   = self;
        picker.sourceType = hasCamera ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(UIImage *)normalizedImage:(UIImage *) thisImage
{
    if (thisImage.imageOrientation == UIImageOrientationUp) return thisImage;
    
    UIGraphicsBeginImageContextWithOptions(thisImage.size, NO, thisImage.scale);
    [thisImage drawInRect:(CGRect){0, 0, thisImage.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    UIImage *imagee =  [self normalizedImage:chosenImage];
    
    float height = 512;
    float width = 512;
    imagee = [self imageWithImage:imagee scaledToFillSize:CGSizeMake(width, height)];
    self.imgProfile.image = imagee;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    

    //[[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([self imageWithImage:imagee scaledToFillSize:CGSizeMake(width, height)])            forKey:@"profileImage"];
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        data= [self compressImage:imagee];

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            
            base64Str = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            
            // base64Str = [self encodeToBase64String:imagee];
        });
    });
    
    

    
    
    
    
}



- (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



-(NSData*)compressImage:(UIImage *)yourImage
{
    yourImage = [UIImage imageWithCGImage:yourImage.CGImage scale:0.3 orientation:yourImage.imageOrientation];

    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 200*1024;
    
    NSData *imageData = UIImageJPEGRepresentation(yourImage, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(yourImage, compression);
    }
    return imageData;
}

@end
