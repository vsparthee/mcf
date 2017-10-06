//
//  ForgotPwdVC.h
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPwdVC : UIViewController
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;
- (IBAction)action_Cancel:(UIButton *)sender;
- (IBAction)action_Forgot:(UIButton *)sender;

@end
