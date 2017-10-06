//
//  UserProfileVC.h
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface UserProfileVC : UIViewController
@property (weak, nonatomic) LeftMenuVC *parent;

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
@property (weak, nonatomic) IBOutlet UIButton *action_Update;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
@property (weak, nonatomic) IBOutlet UIView *settingView;
- (IBAction)action_Setting:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSetting;
- (IBAction)action_ChangePwd:(UIButton *)sender;
- (IBAction)action_ChangePin:(UIButton *)sender;
- (IBAction)action_ChangeLang:(UIButton *)sender;
- (IBAction)action_SignOut:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnMenu;


@end
