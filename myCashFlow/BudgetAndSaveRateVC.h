//
//  BudgetAndSaveRateVC.h
//  myCashflow
//
//  Created by Rishi on 9/29/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PNChart.h"
#import "LeftMenuVC.h"
#import <Charts/Charts.h>
#import "myCashFlow-Swift.h"

@interface BudgetAndSaveRateVC : UIViewController<ChartViewDelegate>

@property (nonatomic, strong) IBOutlet PieChartView *chartView;

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (strong, nonatomic) IBOutlet UIView *budgetView;
//@property (nonatomic) PNPieChart *pieChart;
@property (nonatomic) IBOutlet UIView *pieChartbase;
@property (weak, nonatomic) IBOutlet UIView *legendbase;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *budgetheight;
@property (weak, nonatomic) LeftMenuVC *parent;
- (IBAction)action_Budget:(UIButton *)sender;
- (IBAction)action_Expense:(UIButton *)sender;
- (IBAction)action_Settings:(UIButton *)sender;

- (IBAction)action_SelectMonth:(UIButton *)sender;
- (IBAction)action_MyBudget:(UIButton *)sender;
- (IBAction)action_MySavings:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMyBudget;
@property (weak, nonatomic) IBOutlet UIButton *btnMySavings;
@property (weak, nonatomic) IBOutlet UIButton *SelectMonth;
@property (weak, nonatomic) IBOutlet UILabel *lblMonth;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectMonthExpence;


@property (weak, nonatomic) IBOutlet UIButton *btnExpense;

- (IBAction)action_SettingSubmit:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSettingSubmit;
- (IBAction)action_SettingCancel:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSettingCancel;

@property (weak, nonatomic) IBOutlet UITableView *tblBudget;
@property (weak, nonatomic) IBOutlet UITableView *tblSavings;
@property (weak, nonatomic) IBOutlet UIView *mySavingView;
@property (weak, nonatomic) IBOutlet UIView *myBudgetView;

@property (weak, nonatomic) IBOutlet UITableView *tblExpense;
- (IBAction)action_AddExpense:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *expenseView;
@property (strong, nonatomic) IBOutlet UIView *settingsView;

@property (weak, nonatomic) IBOutlet UITextField *txtTotalEarn;
@property (weak, nonatomic) IBOutlet UITextField *txtHouseRent;
@property (weak, nonatomic) IBOutlet UITextField *txtInsurance;
@property (weak, nonatomic) IBOutlet UITextField *txtTax;
@property (weak, nonatomic) IBOutlet UITextField *txtDailyExpense;

//TabMenu
@property (weak, nonatomic) IBOutlet UILabel *lblBudget;
@property (weak, nonatomic) IBOutlet UIImageView *imgbudget;
@property (weak, nonatomic) IBOutlet UILabel *lblExpense;
@property (weak, nonatomic) IBOutlet UIImageView *imgExpense;
@property (weak, nonatomic) IBOutlet UILabel *lblSetting;
@property (weak, nonatomic) IBOutlet UIImageView *imgSetting;

@property (weak, nonatomic) IBOutlet UILabel *lblMyBudget;
@property (weak, nonatomic) IBOutlet UILabel *lblSaving;
@property (weak, nonatomic) IBOutlet UILabel *lblExp;
@property (weak, nonatomic) IBOutlet UILabel *earnlbl;
@property (weak, nonatomic) IBOutlet UILabel *rentlbl;
@property (weak, nonatomic) IBOutlet UILabel *insurancelbl;
@property (weak, nonatomic) IBOutlet UILabel *taxlbl;
@property (weak, nonatomic) IBOutlet UILabel *expenselbl;
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;


@property (weak, nonatomic) IBOutlet UITableView *tblSetting;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveSetting;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelSetting;
@property (strong, nonatomic) IBOutlet UIView *addsettingsView;
@property (weak, nonatomic) IBOutlet UIButton *btnAddSetting;
- (IBAction)action_AddSetting:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtSettingName;
@property (weak, nonatomic) IBOutlet UITextField *txtSettingValue;
- (IBAction)action_Add:(UIButton *)sender;
- (IBAction)action_CloseDoc:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblValue;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
- (IBAction)action_Setting_Delete:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end
