//
//  FinanceDetailsVC.h
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanceDetailsVC : UIViewController
- (IBAction)action_FurtherInfo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFurtherInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblInsuranceTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblInsuranceType;
@property (weak, nonatomic) IBOutlet UILabel *lblPolicyNum;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblPremiumAmt;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblTenure;
- (IBAction)action_PDF:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPDF;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@property (weak, nonatomic) IBOutlet UILabel *lblProfileName;
@property (weak, nonatomic) IBOutlet UITableView *tblDocList;
@property (strong, nonatomic) IBOutlet UIView *docView;
- (IBAction)action_CloseDoc:(UIButton *)sender;

@property (strong,nonatomic) NSMutableDictionary *selectedFinance;
@end
