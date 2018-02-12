//
//  RecommandationVC.m
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "RecommandationVC.h"

@interface RecommandationVC ()
@property (weak, nonatomic) IBOutlet UIImageView *homeimg;

@end

@implementation RecommandationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeimg.tintColor = [UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Recommendation"];
    self.rcctolbl.text=[TSLanguageManager localizedString:@"Recommendation To"];
    self.numlbl.text=[TSLanguageManager localizedString:@"Mobile Number"];
    self.maillbl.text=[TSLanguageManager localizedString:@"Email Address"];
    self.addrlbl.text=[TSLanguageManager localizedString:@"Address"];
    self.remarklbl.text=[TSLanguageManager localizedString:@"Remark"];
    [self.btnShare setTitle:[TSLanguageManager localizedString:@"Share the myCashflow App on Social Media"] forState:UIControlStateNormal];
    [self.btnUpdate setTitle:[TSLanguageManager localizedString:@"Update"] forState:UIControlStateNormal];

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

- (IBAction)action_Share:(UIButton *)sender
{
    
    [General startLoader:self.view];
    UIImage *myIcon = [UIImage imageNamed:@"Menu 192_1.PNG"];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    
    imgView.image =myIcon;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    imgView.frame = CGRectMake(0, 0, 618,450);
    NSString *dec = @"Hört jetzt auf mit dem unnötigen Papierkrieg!\nBenutzt die myCashflow App um eure Versicherungspolicen, Steuerdokumente und Finanzdokumente ganz einfach auf eurem Smartphone aufzurufen und jederzeit den Überblick zu halten!\nMeldet Schadenmeldungen der Autoversicherung wie auch Leistungsmeldungen der Krankenkasse direkt über die App und spart euch Portokosten!\nIn eurem App- und Googleplay store erhältlich!";
    
    NSString *urlstr = @"http://ccflow.ch/";
    
    
    NSData *data1 = UIImagePNGRepresentation(myIcon);
    
    NSArray * shareItems = @[dec,urlstr,data1];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:avc animated:YES completion:nil];
        [General stopLoader];
    }
    else {
        
        avc.modalPresentationStyle                   = UIModalPresentationPopover;
        avc.popoverPresentationController.sourceView = self.view;
        avc.popoverPresentationController.sourceRect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0);
        [self presentViewController:avc animated:YES completion:nil];
        [General stopLoader];

    }

}
- (IBAction)action_Update:(UIButton *)sender
{
    if ([self validateRequest])
    {
        NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
        NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        
        [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
        [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtRecommandationTo.text] forKey:@"RcommendTo"];
        [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtMobile.text] forKey:@"PhoneNo"];
        [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"EmailID"];
        [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtAddress.text] forKey:@"Address"];
        [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtRemark.text] forKey:@"Remarks"];
        
        
        

        APIHandler *api = [[APIHandler alloc]init];
        
        [api api_Recommendation: apiDic withSuccess:^(id result)
         {
             @try
             {
                 if ([[result valueForKey:@"Status"]boolValue]==true)
                 {
                     [General makeToast:[TSLanguageManager localizedString:@"Successfully Updated"] withToastView:self.view];
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
             [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             [General stopLoader];
         }];

    }
}

-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    
    if(self.txtRecommandationTo.text == NULL || [self.txtRecommandationTo.text isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Enter Your Recommand Name"] withToastView:self.view];

        return validation;
    }
    
    /*else if(self.txtMobile.text == NULL || [self.txtMobile.text isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Enter Your Mobile Number"] withToastView:self.view];

        return validation;
    }

    else if(self.txtEmail.text == NULL || [self.txtEmail.text isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Enter Your Email ID"] withToastView:self.view];

        return validation;
    }
    
    else if(![self validateEmailWithString:self.txtEmail.text])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Enter Valid Email ID"] withToastView:self.view];

        return validation;
    }
    */
    else if(self.txtRemark.text == NULL || [self.txtRemark.text isEqualToString:@""])
    {
        [General makeToast:[TSLanguageManager localizedString:@"Please Enter Remark"] withToastView:self.view];

        [self.remarkBtmView setBackgroundColor:[UIColor redColor]];
        self.remarkheight.constant=2;
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

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [self.remarkBtmView setBackgroundColor:THEME_COLOR];
    self.remarkheight.constant=2;
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self.remarkBtmView setBackgroundColor:[UIColor lightGrayColor]];
    self.remarkheight.constant=1;
    return YES;
    
}
@end
