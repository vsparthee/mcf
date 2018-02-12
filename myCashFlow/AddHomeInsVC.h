//
//  AddHomeInsVC.h
//  myCashflow
//
//  Created by Rishi on 9/26/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddHomeInsVC : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
- (IBAction)action_Menu:(UIButton *)sender;
- (IBAction)action_Back:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgDoc1;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc2;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc3;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc4;

- (IBAction)action_img1:(id)sender;
- (IBAction)action_img2:(UIButton *)sender;
- (IBAction)action_img3:(UIButton *)sender;
- (IBAction)action_img4:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;

@property (weak, nonatomic) IBOutlet UITextField *txtPolicyNum;
- (IBAction)action_Submit:(UIButton *)sender;
- (IBAction)action_Cancel:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblpolicynum;
@property (weak, nonatomic) IBOutlet UILabel *lbldoc;
@property (weak, nonatomic) IBOutlet UILabel *lbldoc2;
@property (weak, nonatomic) IBOutlet UILabel *lblimg1;
@property (weak, nonatomic) IBOutlet UILabel *lblimg2;


@property(nonatomic,strong) UIPickerView *picker;
@property(nonatomic,strong) NSMutableArray *pickerArr;

@end
