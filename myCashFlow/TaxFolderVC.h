//
//  TaxFolderVC.h
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
#import "HVTableView.h"
@interface TaxFolderVC : UIViewController
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet HVTableView *tblTax;
-(IBAction)viewPDF:(UIButton*)sender;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *btnAppointment;
- (IBAction)action_Appointment:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UITableView *tblDocList;
@property (strong, nonatomic) IBOutlet UIView *docView;
- (IBAction)action_CloseDoc:(UIButton *)sender;

@end
