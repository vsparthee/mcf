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
    [self setupAPI];
    
}

-(void)setupAPI
{
    
    APIHandler *api = [[APIHandler alloc]init];
    [api api_ConsulterDetails:^(id result)
     {
         profileDic = [result mutableCopy];
     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         
     }];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"consultant" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    profileDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.lblName.text = [NSString stringWithFormat:@"%@",[profileDic valueForKey:@"Name"]];
    self.lblNumber.text = [NSString stringWithFormat:@"%@",[profileDic valueForKey:@"PhoneNo"]];
    self.lblEmail.text = [NSString stringWithFormat:@"%@",[profileDic valueForKey:@"EmailID"]];
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






- (IBAction)action_Send:(UIButton *)sender {
}
@end
