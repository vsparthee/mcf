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
@end
