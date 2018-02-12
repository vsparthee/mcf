//
//  AddHealthInsVC.m
//  myCashflow
//
//  Created by Rishi on 9/26/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AddHealthInsVC.h"

@interface AddHealthInsVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    float height;
    NSString *imgPath1,*imgPath2,*selectedID;
    int cameraTag;
    NSMutableArray *listarr;
    NSData *data1,*data2;


}
@end

@implementation AddHealthInsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtPolicyNum.userInteractionEnabled=NO;

    self.lbltitle.text=[TSLanguageManager localizedString:@"Add Report"];
    self.lblIns_Card.text=[TSLanguageManager localizedString:@"Insurance Card"];

    self.lblpolicynum.text=[TSLanguageManager localizedString:@"Policy No"];
    self.lbldoc.text=[TSLanguageManager localizedString:@"Document"];
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
    self.viewHeight.constant=height-64;
    self.pickerArr=[[NSMutableArray alloc]init];
    
    
 
    self.txtMessage.text = [TSLanguageManager localizedString:@"Enter Comment Here"];
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
                     
                     if (!([[dic valueForKey:@"Type"]rangeOfString:@"healt" options:NSCaseInsensitiveSearch].location == NSNotFound))
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
        self.txtMessage.text = [TSLanguageManager localizedString:@"Enter Comment Here"];
        [self.txtMessage resignFirstResponder];
        
    }
    return YES;
    
}
-(void) textViewDidChange:(UITextView *)textView
{
    if(self.txtMessage.text.length == 0 || [self.txtMessage.text isEqualToString:@""] || self.txtMessage == NULL)
    {
        self.txtMessage.textColor = [UIColor lightGrayColor];
        self.txtMessage.text = [TSLanguageManager localizedString:@"Enter Comment Here"];
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
            self.txtMessage.text = [TSLanguageManager localizedString:@"Enter Comment Here"];
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



- (IBAction)action_img1:(id)sender
{
    cameraTag=1;
    [self changePhoto];
}

- (IBAction)action_img2:(UIButton *)sender
{
    cameraTag=2;
    [self changePhoto];
    
    
}
- (void)changePhoto
{
    
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
        self.imgDoc1.image = imagee;
        self.imgDoc1.backgroundColor=[UIColor clearColor];

        imgPath1 = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        data1= [self compressImage:imagee];

        
    }
    else
    {
        
        self.imgDoc2.image = imagee;
        self.imgDoc2.backgroundColor=[UIColor clearColor];
        imgPath2 = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        data2= [self compressImage:imagee];
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


- (IBAction)action_Submit:(UIButton *)sender {
    if ([self imageValidation])
    {
        [General startLoader:self.view];
        NSString * url = [NSString stringWithFormat:API_CreateHealthAccident,BASE_URL];
        NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
        [dic setValue:[NSString stringWithFormat:@"%@",selectedID] forKey:@"policyNo"];
        if (![_txtMessage.text isEqualToString:[TSLanguageManager localizedString:@"Enter Comment Here"]])
        {
            [dic setValue:[NSString stringWithFormat:@"%@",_txtMessage.text] forKey:@"Comments"];
            
        }
        else
        {
            [dic setValue:[NSString stringWithFormat:@""] forKey:@"Comments"];
        }        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (data1!=nil)
            {
                [formData appendPartWithFileData:data1
                                            name:@"Document1"
                                        fileName:@"Document1.jpeg" mimeType:@"image/jpeg"];
            }
            if (data2!=nil)
            {
                [formData appendPartWithFileData:data2
                                            name:@"Document2"
                                        fileName:@"Document2.jpeg" mimeType:@"image/jpeg"];
            }
            
            
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
         {
             @try
             {
                 if ([[responseObject valueForKey:@"status"] boolValue]==true)
                 {
                     [General makeToast:@"Document/Images added successfully" withToastView:self.view];
                     self.imgDoc1.image=nil;
                     self.imgDoc2.image=nil;
                     self.imgDoc1.backgroundColor=[UIColor lightGrayColor];
                     self.imgDoc2.backgroundColor=[UIColor lightGrayColor];
                     self.txtMessage.text = [TSLanguageManager localizedString:@"Enter Comment Here"];
                     self.txtMessage.textColor = [UIColor lightGrayColor];

                     imgPath1=nil;
                     imgPath2=nil;
                     
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
    if(self.txtPolicyNum.text == NULL || [self.txtPolicyNum.text isEqualToString:@""])
    {
        [General makeToast:@"Please enter policy number" withToastView:self.view];
        
        return validation;
    }
    
//    else if(imgPath1 == NULL || [imgPath1 isEqualToString:@""])
//    {
//        [General makeToast:@"Please add images before submit" withToastView:self.view];
//        return validation;
//    }
//    
//    else if(imgPath2 == NULL || [imgPath2 isEqualToString:@""])
//    {
//        [General makeToast:@"Please add images before submit" withToastView:self.view];
//        return validation;
//    }
    else if (data1|| data2)
    {
        validation = true;
        return validation;
        
    }
    else
    {
        return validation;
    }
    return validation;
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
            self.txtPolicyNum.text =title;
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
