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
- (IBAction)action_img1:(id)sender;
- (IBAction)action_img2:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtPolicyNum;


@end
