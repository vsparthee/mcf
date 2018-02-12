//
//  ConsultorProfileVC.m
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ConsultorProfileVC.h"

@interface ConsultorProfileVC ()<UITextViewDelegate>
{
    NSMutableDictionary *profileDic;
}
@end

@implementation ConsultorProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Consultor Profile"];
    self.namelbl.text=[TSLanguageManager localizedString:@"Name"];
    self.numlbl.text=[TSLanguageManager localizedString:@"Contact Number"];
    self.maillbl.text=[TSLanguageManager localizedString:@"Email Address"];
    self.msglbl.text=[TSLanguageManager localizedString:@"Enter Your Message"];
    [self.btnSend setTitle:[TSLanguageManager localizedString:@"Send Message"] forState:UIControlStateNormal];

    self.lblName.text = @"";
    self.lblNumber.text = @"";
    self.lblEmail.text = @"";

    [self setupAPI];
    
}

-(void)setupAPI
{
   
    [General startLoader:self.view];
    
    APIHandler *api = [[APIHandler alloc]init];
    [api api_ConsulterDetails:^(id result)
     {
         @try
         {
             profileDic = (NSMutableDictionary*)[result mutableCopy];
             self.lblName.text = [NSString stringWithFormat:@"%@",[profileDic valueForKey:@"Name"]];
             self.lblNumber.text = [NSString stringWithFormat:@"%@",[profileDic valueForKey:@"PhoneNo"]];
             self.lblEmail.text = [NSString stringWithFormat:@"%@",[profileDic valueForKey:@"EmailID"]];
             [[SDImageCache sharedImageCache] removeImageForKey:[profileDic valueForKey:@"photoimg"] fromDisk:YES];

             if ([[profileDic valueForKey:@"photoimg"] isKindOfClass:[NSNull class]])
             {
                 self.imgProfile.image = [UIImage imageNamed:@"Consultor Image 384_384.PNG"];
             }
             else
             {
                 NSString *strURL = [NSString stringWithFormat:@"%@",[profileDic valueForKey:@"photoimg"]];
                 NSURL *url = [NSURL URLWithString:strURL];
                 [self.imgProfile setShowActivityIndicatorView:YES];
                 [self.imgProfile setIndicatorStyle:UIActivityIndicatorViewStyleGray];
                 [self.imgProfile sd_setImageWithURL:url
                              placeholderImage:nil
                                       options:SDWebImageRefreshCached];
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
    
    
    NSLog(@"%@",profileDic);
    self.txtMessage.text = @"Enter Message Here";
    self.txtMessage.textColor = [UIColor lightGrayColor];
    self.txtMessage.delegate=self;


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        self.txtMessage.text = @"Enter Message Here";
        [self.txtMessage resignFirstResponder];
        
    }
    return YES;
    
}
-(void) textViewDidChange:(UITextView *)textView
{
    if(self.txtMessage.text.length == 0 || [self.txtMessage.text isEqualToString:@""] || self.txtMessage == NULL)
    {
        self.txtMessage.textColor = [UIColor lightGrayColor];
        self.txtMessage.text = @"Enter Message Here";
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
            self.txtMessage.text = @"Enter Message Here";
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



-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    
    if(self.txtMessage.text == NULL || [self.txtMessage.text isEqualToString:@""])
    {
        return validation;
    }
    else
    {
        validation = true;
        return validation;
    }
    return validation;
}


- (IBAction)action_Send:(UIButton *)sender
{
    if ([self validateRequest])
    {
        [General startLoader:self.view];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"customerID"];
        [dic setObject:[userInfo valueForKey:@"ConsultantID"] forKey:@"consultantID"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.txtMessage.text] forKey:@"remarks"];
        
        APIHandler *api = [[APIHandler alloc]init];
        
        [api api_ConsultantComments:dic withSuccess:^(id result)
        {
            @try
            {
                if ([result[@"Status"]boolValue]==true)
                {
                    [General makeToast:[TSLanguageManager localizedString:@"Success"] withToastView:self.view];
                    self.txtMessage.text = @"Enter Message Here";
                    self.txtMessage.textColor = [UIColor lightGrayColor];

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
            
        }
        failure:^(NSURLSessionTask *operation, NSError *error)
        {
            [General stopLoader];

        }];
    }

}
@end
