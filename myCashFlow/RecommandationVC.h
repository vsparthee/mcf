//
//  RecommandationVC.h
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface RecommandationVC : UIViewController
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtRecommandationTo;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtMobile;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextView *txtRemark;
- (IBAction)action_Share:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)action_Update:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
@property (weak, nonatomic) IBOutlet UIView *remarkBtmView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkheight;

@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *rcctolbl;
@property (weak, nonatomic) IBOutlet UILabel *numlbl;
@property (weak, nonatomic) IBOutlet UILabel *maillbl;
@property (weak, nonatomic) IBOutlet UILabel *addrlbl;
@property (weak, nonatomic) IBOutlet UILabel *remarklbl;

@end
