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
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc;
@property (weak, nonatomic) IBOutlet UIImageView *imgFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgRight;
- (IBAction)action_Front:(UIButton *)sender;
- (IBAction)action_BackImg:(UIButton *)sender;
- (IBAction)action_Left:(UIButton *)sender;
- (IBAction)action_Right:(UIButton *)sender;

- (IBAction)action_Submit:(UIButton *)sender;
- (IBAction)action_Cancel:(UIButton *)sender;
- (IBAction)action_Doc:(UIButton *)sender;



@end
