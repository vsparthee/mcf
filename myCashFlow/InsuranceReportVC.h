//
//  InsuranceReportVC.h
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceReportVC : UIViewController
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *btnReport;
- (IBAction)action_Report:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblReport;
- (IBAction)action_Menu:(UIButton *)sender;
- (IBAction)action_Back:(UIButton *)sender;
@property (assign, nonatomic) int type;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBtn;

@end
