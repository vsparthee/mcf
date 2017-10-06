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

}
@end

@implementation UserProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    self.txtAddress.text=[NSString stringWithFormat:@"%@,%@",[userInfo valueForKey:@"Address1"],[userInfo valueForKey:@"Address2"]];
    self.txtDOB.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"DOB"]];
    self.txtEmail.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Emailid"]];
    self.txtFirstName.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Firstname"]];
    self.txtLastName.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Lastname"]];
    self.txtPhone.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Phoneno"]];
    self.txtOccupation.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"Occupation"]];
    self.txtMobile.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"landlineNo"]];
    self.txtPostal.text=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"postcode"]];


    
    // Do any additional setup after loading the view.
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
- (IBAction)action_Male:(UIButton *)sender {
}

- (IBAction)action_Female:(UIButton *)sender {
}
- (IBAction)action_Setting:(UIButton *)sender
{
    if (self.settingView.hidden)
    {
        self.settingView.hidden=NO;
    }
    else
    {
        self.settingView.hidden=YES;

    }
}
- (IBAction)action_ChangePwd:(UIButton *)sender {
}

- (IBAction)action_ChangePin:(UIButton *)sender {
}

- (IBAction)action_ChangeLang:(UIButton *)sender {
}

- (IBAction)action_SignOut:(UIButton *)sender {
}


- (void)changePhoto{
    
    NSLog(@"Inside Image Change...");
    UIActionSheet  *webSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Albums", nil),NSLocalizedString(@"Take a Photo", nil), nil];
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
    
    self.imgProfile.image = [self imageWithImage:imagee scaledToFillSize:CGSizeMake(width, height)];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    __block NSData  *iData=nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        iData=[self compressImage:imagee];
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            
            base64Str = [iData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            
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
