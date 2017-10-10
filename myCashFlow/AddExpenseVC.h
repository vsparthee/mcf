//
//  AddExpenseVC.h
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddExpenseVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
- (IBAction)action_Submit:(UIButton *)sender;
- (IBAction)action_Cancel:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *datelbl;
@property (weak, nonatomic) IBOutlet UILabel *desclbl;
@property (weak, nonatomic) IBOutlet UILabel *amtlbl;
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@end
