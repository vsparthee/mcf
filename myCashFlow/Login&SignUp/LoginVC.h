//
//  LoginVC.h
//  myCashFlow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtUserName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnForgot;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)action_Login:(UIButton *)sender;
- (IBAction)action_Forget:(UIButton *)sender;
- (IBAction)action_Register:(UIButton *)sender;

@end
