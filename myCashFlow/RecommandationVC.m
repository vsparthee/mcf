//
//  RecommandationVC.m
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "RecommandationVC.h"

@interface RecommandationVC ()

@end

@implementation RecommandationVC

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)action_Share:(UIButton *)sender {
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
             
         }
        failure:^(NSURLSessionTask *operation, NSError *error)
         {
             
         }];

    }
}

-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    
    if(self.txtRecommandationTo.text == NULL || [self.txtRecommandationTo.text isEqualToString:@""])
    {
        [self.txtRecommandationTo showErrorWithText:@"Enter Your Recommand Name"];
        return validation;
    }
    
    else if(self.txtMobile.text == NULL || [self.txtMobile.text isEqualToString:@""])
    {
        [self.txtMobile showErrorWithText:@"Enter Your Mobile Number"];
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
    
    else if(self.txtRemark.text == NULL || [self.txtRemark.text isEqualToString:@""])
    {
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
