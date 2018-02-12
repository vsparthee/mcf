//
//  AddCarAccident.h
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCarAccident : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
- (IBAction)action_Menu:(UIButton *)sender;
- (IBAction)action_Back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtPolicyNum;
@property (weak, nonatomic) IBOutlet UIImageView *imgFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgRight;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc1;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc2;

- (IBAction)action_Front:(UIButton *)sender;
- (IBAction)action_BackImg:(UIButton *)sender;
- (IBAction)action_Left:(UIButton *)sender;
- (IBAction)action_Right:(UIButton *)sender;
- (IBAction)action_img1:(id)sender;
- (IBAction)action_img2:(UIButton *)sender;

- (IBAction)action_Submit:(UIButton *)sender;
- (IBAction)action_Cancel:(UIButton *)sender;
- (IBAction)action_Doc:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextView *txtMessage;

@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblpolicynum;
@property (weak, nonatomic) IBOutlet UILabel *lblcardoc;
@property (weak, nonatomic) IBOutlet UILabel *lblfront;
@property (weak, nonatomic) IBOutlet UILabel *lblback;
@property (weak, nonatomic) IBOutlet UILabel *lblleg;
@property (weak, nonatomic) IBOutlet UILabel *lblright;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property(nonatomic,strong) UIPickerView *picker;
@property(nonatomic,strong) NSMutableArray *pickerArr;

@end
