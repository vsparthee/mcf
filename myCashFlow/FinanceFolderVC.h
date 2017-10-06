//
//  FinanceFolderVC.h
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface FinanceFolderVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblPrivate;
@property (weak, nonatomic) IBOutlet UITableView *tblCompany;
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet UIView *tblView;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivate;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
- (IBAction)action_Private:(UIButton *)sender;
- (IBAction)action_Company:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *privateView;
@property (weak, nonatomic) IBOutlet UIView *companyView;

@end
