//
//  ChangePwdVC.h
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePwdVC : UIViewController
- (IBAction)action_ChangePwd:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtoldpwd;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtnewpwd;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtconfirmpwd;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UIButton *btnchange;

@end
