//
//  ConsultorProfileVC.h
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface ConsultorProfileVC : UIViewController
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
- (IBAction)action_Send:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;


@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *namelbl;

@property (weak, nonatomic) IBOutlet UILabel *numlbl;
@property (weak, nonatomic) IBOutlet UILabel *maillbl;
@property (weak, nonatomic) IBOutlet UILabel *msglbl;

@end
