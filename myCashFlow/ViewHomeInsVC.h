//
//  ViewHomeInsVC.h
//  myCashflow
//
//  Created by Rishi on 9/26/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewHomeInsVC : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
- (IBAction)action_Menu:(UIButton *)sender;
- (IBAction)action_Back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblPolicyNum;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc1;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc2;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc3;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc4;
@property (weak, nonatomic) IBOutlet UITextView *lblComment;
@property (weak, nonatomic) IBOutlet UILabel *lblcmt;

@property (strong,nonatomic) NSMutableDictionary *selectedDic;

@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblpolicynum;
@property (weak, nonatomic) IBOutlet UILabel *lbldoc;
@property (weak, nonatomic) IBOutlet UILabel *lbldoc2;
@property (weak, nonatomic) IBOutlet UILabel *lblimg1;
@property (weak, nonatomic) IBOutlet UILabel *lblimg2;@end
