//
//  AccidentReportVC.h
//  myCashflow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface AccidentReportVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgcar;
@property (weak, nonatomic) IBOutlet UIImageView *imghealth;
@property (weak, nonatomic) IBOutlet UIImageView *imghome;
@property (weak, nonatomic) LeftMenuVC *parent;
- (IBAction)action_Insurance:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblcar;
@property (weak, nonatomic) IBOutlet UILabel *lblhealth;
@property (weak, nonatomic) IBOutlet UILabel *lblhome;




@end
