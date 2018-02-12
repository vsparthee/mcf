//
//  AddCarAccident.m
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AddCarAccident.h"

@interface AddCarAccident ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate>

{
    float height;
    int cameraTag;
    NSString *imgfrontPath,*imgbackPath,*imgleftPath,*imgrightPath,*imgdoc1Path,*imgdoc2Path,*selectedID;
    NSData *doc1,*doc2,*front,*back,*left,*right;
    NSString *base64Str;
    

}
@end

@implementation AddCarAccident

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtPolicyNum.userInteractionEnabled=NO;

    self.lbltitle.text=[TSLanguageManager localizedString:@"Add Report"];
    self.lblpolicynum.text=[TSLanguageManager localizedString:@"Policy No"];
    self.lblcardoc.text=[TSLanguageManager localizedString:@"Car Document"];
    self.lblfront.text=[TSLanguageManager localizedString:@"Front Side"];
    self.lblback.text=[TSLanguageManager localizedString:@"Back Side"];
    self.lblright.text=[TSLanguageManager localizedString:@"Right Side"];
    self.lblleg.text=[TSLanguageManager localizedString:@"Left Side"];
    [self.btnSubmit setTitle:[TSLanguageManager localizedString:@"Submit"] forState:UIControlStateNormal];
    [self.btnCancel setTitle:[TSLanguageManager localizedString:@"Cancel"] forState:UIControlStateNormal];

    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        height=[UIScreen mainScreen].bounds.size.width;
    }
    else
    {
        height=[UIScreen mainScreen].bounds.size.height;
    }
    self.viewHeight.constant=height-64;
    self.pickerArr=[[NSMutableArray alloc]init];
    [General startLoader:self.view];
    
    self.picker = [[UIPickerView alloc]init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.hidden = NO;
    self.picker.showsSelectionIndicator = YES;
    self.picker.tag = 0;
    self.txtPolicyNum.inputView = self.picker;
    self.txtPolicyNum.inputView.backgroundColor =[UIColor whiteColor];
    self.txtPolicyNum.delegate = self;
    self.txtPolicyNum.delegate = self;
    
    
    self.txtMessage.text = [TSLanguageManager localizedString:@"Can you describe the damage"];
    self.txtMessage.textColor = [UIColor lightGrayColor];
    self.txtMessage.delegate=self;

    
    
    APIHandler *api = [[APIHandler alloc]init];
    [api api_financeFolder:^(id result)
     {
         @try
         {
             NSMutableArray *finalarr=[result valueForKey:@"data"];
             if (finalarr.count>0)
             {
                 for (NSDictionary *dic in finalarr)
                 {
                     if (!([[dic valueForKey:@"Type"]rangeOfString:@"car" options:NSCaseInsensitiveSearch].location == NSNotFound))
                     {
                         NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
                         [temp setObject:[dic valueForKey:@"Policy_id"] forKey:@"Policy_id"];
                         [temp setObject:[dic valueForKey:@"PolicyNo"] forKey:@"PolicyNo"];
                         [temp setObject:[dic valueForKey:@"ProductName"] forKey:@"ProductName"];
                         [self.pickerArr addObject:temp];
                     }
                     
                 }
             }
             if (self.pickerArr.count>0)
             {
                 NSDictionary *temp=[self.pickerArr objectAtIndex:0];
                 selectedID=[NSString stringWithFormat:@"%@",[temp valueForKey:@"Policy_id"]];
                 
                 self.txtPolicyNum.userInteractionEnabled=YES;
                 
             }
             else
             {
                 self.txtPolicyNum.userInteractionEnabled=NO;
             }
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

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.txtMessage.textColor == [UIColor lightGrayColor]) {
        self.txtMessage.text = @"";
        self.txtMessage.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(self.txtMessage.text.length == 0 || [self.txtMessage.text isEqualToString:@""] || self.txtMessage == NULL)
    {
        self.txtMessage.textColor = [UIColor lightGrayColor];
        self.txtMessage.text = [TSLanguageManager localizedString:@"Can you describe the damage"];
        [self.txtMessage resignFirstResponder];
        
    }
    return YES;
    
}
-(void) textViewDidChange:(UITextView *)textView
{
    if(self.txtMessage.text.length == 0 || [self.txtMessage.text isEqualToString:@""] || self.txtMessage == NULL)
    {
        self.txtMessage.textColor = [UIColor lightGrayColor];
        self.txtMessage.text = [TSLanguageManager localizedString:@"Can you describe the damage"];
        [self.txtMessage resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSUInteger newLength = [self.txtMessage.text length] + [text length] - range.length;
    
    if([text isEqualToString:@"\n"] || newLength == 0)
    {
        [textView resignFirstResponder];
        if(self.txtMessage.text.length == 0 || newLength == 0)
        {
            self.txtMessage.textColor = [UIColor lightGrayColor];
            self.txtMessage.text = [TSLanguageManager localizedString:@"Can you describe the damage"];
            [self.txtMessage resignFirstResponder];
            
            return NO;
            
        }
        else
        {
            return YES;
            
        }
    }
    return YES;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.viewHeight.constant=height;
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.viewHeight.constant=height-64;
        
    }
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
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)action_Front:(UIButton *)sender {
    cameraTag=1;

    [self changePhoto];

}

- (IBAction)action_BackImg:(UIButton *)sender {
    cameraTag=2;

    [self changePhoto];

}

- (IBAction)action_Left:(UIButton *)sender {
    cameraTag=3;

    [self changePhoto];

}

- (IBAction)action_Right:(UIButton *)sender {
    cameraTag=4;

    [self changePhoto];

}


- (IBAction)action_Cancel:(UIButton *)sender {
    if( [self navigationController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }

}

- (IBAction)action_img1:(id)sender
{
    cameraTag=5;
    [self changePhoto];
}

- (IBAction)action_img2:(UIButton *)sender
{
    cameraTag=6;
    [self changePhoto];
}

- (IBAction)action_Submit:(UIButton *)sender
{
    
    if ([self imageValidation])
    {
        [General startLoader:self.view];
        NSString * url = [NSString stringWithFormat:API_CreateCarAccident,BASE_URL];
        NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
        [dic setValue:[NSString stringWithFormat:@"%@",selectedID] forKey:@"policyNo"];
        if (![_txtMessage.text isEqualToString:[TSLanguageManager localizedString:@"Can you describe the damage"]])
        {
            [dic setValue:[NSString stringWithFormat:@"%@",_txtMessage.text] forKey:@"Comments"];

        }
        else
        {
            [dic setValue:[NSString stringWithFormat:@""] forKey:@"Comments"];
        }
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
           /* NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
            
            
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"CustomerID"]] dataUsingEncoding:NSUTF8StringEncoding] name:@"CustomerID"];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",selectedID] dataUsingEncoding:NSUTF8StringEncoding] name:@"PolicyType"];
            if (![_txtMessage.text isEqualToString:[TSLanguageManager localizedString:@"Can you describe the damage"]])
            {
                [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",_txtMessage.text] dataUsingEncoding:NSUTF8StringEncoding] name:@"PolicyType"];

                
            }
            else
            {
                [formData appendPartWithFormData:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding] name:@"PolicyType"];
            }

            
            */
            
            if(doc1!=nil)
            {
            [formData appendPartWithFileData:doc1
                                        name:@"CarInsuranceDoc"
                                    fileName:@"CarInsuranceDoc.jpeg" mimeType:@"image/jpeg"];
            }
        /*    [formData appendPartWithFileData:doc2
                                        name:@"CarRCDoc"
                                    fileName:@"CarRCDoc.jpeg" mimeType:@"image/jpeg"];*/
            if(front!=nil)
            {
                [formData appendPartWithFileData:front
                                        name:@"front"
                                    fileName:@"front.jpeg" mimeType:@"image/jpeg"];
            }
            if(back!=nil)
            {
                [formData appendPartWithFileData:back
                                            name:@"back"
                                        fileName:@"back.jpeg" mimeType:@"image/jpeg"];
            }
            
            if(left!=nil)
            {
                [formData appendPartWithFileData:left
                                            name:@"left"
                                        fileName:@"left.jpeg" mimeType:@"image/jpeg"];
            }
            
            if(right!=nil)
            {
                [formData appendPartWithFileData:right
                                            name:@"right"
                                        fileName:@"right.jpeg" mimeType:@"image/jpeg"];
            }
            
   
            
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
         {
             @try
             {
                 if ([[responseObject valueForKey:@"status"] boolValue]==true)
                 {
                     [General makeToast:[TSLanguageManager localizedString:@"Document/Images added successfully"] withToastView:self.view];
                     self.imgDoc1.image=[UIImage imageNamed:@"bg1.jpg"];
                     self.imgDoc2.image=[UIImage imageNamed:@"bg.jpg"];
                     self.imgFront.image=[UIImage imageNamed:@"bg.jpg"];
                     self.imgBack.image=[UIImage imageNamed:@"bg.jpg"];
                     self.imgLeft.image=[UIImage imageNamed:@"bg.jpg"];
                     self.imgRight.image=[UIImage imageNamed:@"bg.jpg"];
                     imgdoc1Path=nil;
                     imgdoc2Path=nil;
                     imgfrontPath=nil;
                     imgbackPath=nil;
                     imgleftPath=nil;
                     imgrightPath=nil;
                     self.txtMessage.text = [TSLanguageManager localizedString:@"Can you describe the damage"];
                     self.txtMessage.textColor = [UIColor lightGrayColor];

                     
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

-(BOOL)imageValidation
{
    BOOL validation = FALSE;
    if(selectedID == NULL || [selectedID isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please select policy number"] withToastView:self.view];
        
        return validation;
    }
    
//    else if(doc1)
//    {
//        [General makeToast:[TSLanguageManager localizedString:@"Please add images before submit"] withToastView:self.view];
//        return validation;
//    }
    
    else if (left || front || back || right || doc1)
    {
        validation = true;
        return validation;
    }
    
  /*  else if(imgdoc2Path == NULL || [imgdoc2Path isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please add images before submit"] withToastView:self.view];
        return validation;
    }
    else if(imgfrontPath == NULL || [imgfrontPath isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please add images before submit"] withToastView:self.view];
        return validation;
    }
    else if(imgbackPath == NULL || [imgbackPath isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please add images before submit"] withToastView:self.view];
        return validation;
    }
    else if(imgrightPath == NULL || [imgrightPath isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please add images before submit"] withToastView:self.view];
        return validation;
    }
    else if(imgleftPath == NULL || [imgleftPath isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please add images before submit"] withToastView:self.view];
        return validation;
    }*/
    else
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please add images before submit"] withToastView:self.view];

        return validation;
    }
    return validation;
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

    if (cameraTag==1)
    {

        self.imgFront.image = imagee;
        imgfrontPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        front= [self compressImage:imagee];

        
        
    }
    else if (cameraTag==2)
    {
        self.imgBack.image = imagee;
        imgbackPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        back= [self compressImage:imagee];



    }
    else if (cameraTag==3)
    {
        self.imgLeft.image = imagee;
        imgleftPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        left= [self compressImage:imagee];
        
        

    }
    else if (cameraTag==4)
    {
        self.imgRight.image = imagee;
        imgrightPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        right= [self compressImage:imagee];
        
        


    }
    else if (cameraTag==5)
    {
        self.imgDoc1.image = imagee;
        imgdoc1Path = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        doc1= [self compressImage:imagee];
        
        


    }
    else
    {
        self.imgDoc2.image = imagee;
        imgdoc2Path = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        doc2= [self compressImage:imagee];


    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



- (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat imgwidth = image.size.width * scale;
    CGFloat imgheight = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - imgwidth)/2.0f,
                                  (size.height - imgheight)/2.0f,
                                  imgwidth,
                                  imgheight);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if([_pickerArr count] == 0)
    {
        return 1;
    }
    else
    {
        return _pickerArr.count;
    }
    
}

/*- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
 {
 if(pickerView.tag==0)
 {
 if(_countryArr.count == 0)
 {
 return @"No data available";
 }
 else
 {
 return [_countryArr objectAtIndex:row];
 }
 }
 else  if(pickerView.tag==1)
 {
 if(_stateArr.count == 0)
 {
 return @"No data available";
 }
 else
 {
 return [_stateArr objectAtIndex:row];
 }
 }
 else
 {
 return 0;
 }
 }
 */

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *temp=[_pickerArr objectAtIndex:row];
    self.txtPolicyNum.text = [NSString stringWithFormat:@"%@ (%@)",[temp valueForKey:@"ProductName"],[temp valueForKey:@"PolicyNo"]];
    selectedID=[NSString stringWithFormat:@"%@",[temp valueForKey:@"Policy_id"]];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSDictionary *temp=[_pickerArr objectAtIndex:row];
    
    NSString *title;
    if(_pickerArr.count == 0)
    {
        title =   @"No data available";
    }
    else
    {
        title = [NSString stringWithFormat:@"%@ (%@)",[temp valueForKey:@"ProductName"],[temp valueForKey:@"PolicyNo"]];
        self.txtPolicyNum.text=title;

    }
    
    
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:THEME_FONT size:18]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        [tView setTextColor:[UIColor darkGrayColor]];

        tView.numberOfLines=3;
    }
    tView.text=title;
    return tView;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:self.txtPolicyNum])
    {
        return NO;
    }
    return YES;
}

@end
