//
//  RegisterVC.h
//  myCashFlow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
- (IBAction)action_EditImage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEditImg;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtFirstName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtLastName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtDOB;
- (IBAction)action_Male:(UIButton *)sender;
- (IBAction)action_Female:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgMale;
@property (weak, nonatomic) IBOutlet UIImageView *imgFemale;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtNationality;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtOccupation;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPhone;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtMobile;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPostal;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtAddress;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtRepassword;

@property (weak, nonatomic) IBOutlet UIButton *action_Update;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;



@property (weak, nonatomic) IBOutlet UIButton *btnAlreadyMember;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

- (IBAction)action_Already_Member:(UIButton *)sender;

- (IBAction)action_Register:(UIButton *)sender;


@end
