//
//  BudgetAndSaveRateVC.m
//  myCashflow
//
//  Created by Rishi on 9/29/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "BudgetAndSaveRateVC.h"
#import "MySavingsCell.h"
#import "ExpenseCell.h"
#import "LTHMonthYearPickerView.h"
@interface BudgetAndSaveRateVC ()<UITextFieldDelegate,LTHMonthYearPickerViewDelegate>
{
    CGRect baseViewRect;
    NSMutableArray *mySavingArr,*pieChartArr,*budgetArr,*myExpenseArr;
    NSMutableDictionary *settingDic;
    UILabel *nodata;
    int total;
    UIDatePicker *datePicker;
    UIBarButtonItem *rightBtn;
}
@property (nonatomic, strong) LTHMonthYearPickerView *monthYearPicker;

@end

@implementation BudgetAndSaveRateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    baseViewRect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-124);
    self.budgetView.frame=baseViewRect;
    [self.baseView addSubview:self.budgetView];
    self.lblBudget.textColor=THEME_COLOR;
    self.imgbudget.tintColor=THEME_COLOR;
    
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = @"No data founds in product solution";
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;
    
    [self.btnMyBudget setBackgroundColor:THEME_COLOR];
    [self.btnMySavings setBackgroundColor:[UIColor lightGrayColor]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-yyyy";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    self.txtSelectMonth.text=dateStr;
   
    self.txtSelectMonth.delegate=self;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MM / yyyy"];
    NSDate *minDate = [dateFormatter dateFromString:[NSString stringWithFormat: @"%i / %i", 1, 2000]];
    NSDate *maxDate = [dateFormatter dateFromString:[NSString stringWithFormat: @"%i / %i", 12, 2115]];
    
    _monthYearPicker = [[LTHMonthYearPickerView alloc] initWithDate: [NSDate date]
                                                        shortMonths: NO
                                                     numberedMonths: NO
                                                         andToolbar: YES
                                                            minDate: minDate
                                                         andMaxDate: maxDate];
    _monthYearPicker.delegate = self;
    _txtSelectMonth.delegate = self;
    [self.txtSelectMonth setInputAccessoryView:_monthYearPicker];
    [_txtSelectMonth becomeFirstResponder];
    _monthYearPicker.backgroundColor=BG_COLOR;
  //  [self setupBudgetView:dateStr];
  //  [self setupExpenseApi:dateStr];
    [self setupSettingsApi];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:self.txtSelectMonth])
    {
        return NO;
    }
    return YES;
}
-(void)setupBudgetView:(NSString*)datestr
{
    //[General startLoader:self.view];
    total=0;
    
    pieChartArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    [apiDic setObject:datestr forKey:@"selectedMonth"];
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_MyBudget: apiDic withSuccess:^(id result)
     {
         budgetArr=[[NSMutableArray alloc]init];
         mySavingArr=[[NSMutableArray alloc]init];
         budgetArr = [result valueForKey:@"MyBudget"];
         mySavingArr = [result valueForKey:@"MySaving"];
         [self setupBudgetPieView];
         [General stopLoader];
     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         [General stopLoader];
     }];
    
}

-(void)setupBudgetPieView
{
    if (budgetArr.count>0)
    {
        for (NSDictionary *dic in budgetArr)
        {
            NSString *amt = [dic valueForKey:@"amount"];
            NSString * newString = [amt stringByReplacingOccurrencesOfString:@"CHF" withString:@""];
            amt=[newString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            total += [amt intValue];
            PNPieChartDataItem *item=[PNPieChartDataItem dataItemWithValue:[amt intValue] color:[self test] description:[dic valueForKey:@"CategoryName"]];
            [pieChartArr addObject:item];
        }
        [self.pieChartbase setHidden:NO];
        [self.legendbase setHidden:NO];

        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0,0,260,260) items:pieChartArr];
        
        
        
        self.pieChart.descriptionTextColor = [UIColor whiteColor];
        self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Century Gothic" size:12];
        self.pieChart.descriptionTextShadowColor = [UIColor whiteColor];
        self.pieChart.showAbsoluteValues = YES;
        self.pieChart.showOnlyValues = NO;
        self.pieChart.enableMultipleSelection=NO;
        [self.pieChart strokeChart];
        
        self.tblSavings.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tblExpense.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        self.pieChart.legendStyle = PNLegendItemStyleStacked;
        self.pieChart.legendFont = [UIFont fontWithName:@"Century Gothic" size:15];
        UIView *legend;
        [legend removeFromSuperview];
        legend=[[UIView alloc]init];
        legend = [self.pieChart getLegendWithMaxWidth:SCREEN_WIDTH-60];
        [legend setFrame:CGRectMake(24, 0, SCREEN_WIDTH-48, legend.frame.size.height)];
        [self.legendbase addSubview:legend];
        
        self.budgetheight.constant = legend.frame.size.height+360;
        
        [self.pieChartbase addSubview:self.pieChart];
        
        self.lblTotal.text =[NSString stringWithFormat:@"Total\n%d",total];
    }
    else
    {
        [self.pieChartbase setHidden:YES];
        [self.legendbase setHidden:YES];
        self.budgetheight.constant = 360;

    }
  
    if (mySavingArr.count>0)
    {
        [nodata removeFromSuperview];
    }
    else
    {
        [self.tblSavings addSubview:nodata];
    }
    [self.tblSavings reloadData];
    [General stopLoader];

}

-(void)setupExpenseApi:(NSString*)datestr
{
    NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    [apiDic setObject:datestr forKey:@"selectedMonth"];
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_MyBudgetDailyExpense: apiDic withSuccess:^(id result)
     {
         myExpenseArr = [result valueForKey:@"data"];
         if (myExpenseArr.count>0)
         {
             [nodata removeFromSuperview];
         }
         else
         {
             [self.tblSavings addSubview:nodata];
         }
         [self.tblExpense reloadData];
     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         
     }];

}

-(void)setupSettingsApi
{
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_MyBudgetSetting:^(id result)
    {
        settingDic = [result mutableCopy];
        
        self.txtHouseRent.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"HouseRent"]];
        self.txtTax.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"Tax"]];
        self.txtInsurance.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"Insurance"]];
        self.txtTotalEarn.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"TotalEarnings"]];
        self.txtDailyExpense.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"DailyExpense"]];

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIColor*)test
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)action_Menu:(UIButton *)sender
{
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (IBAction)action_Back:(UIButton *)sender
{
    if( [self navigationController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.parent home];
    }
}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==100)
    {
        return mySavingArr.count;
    }
    else
    {
        return myExpenseArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MySavingsCell" owner:self options:nil];
        MySavingsCell *cell = [nib objectAtIndex:0];
        NSDictionary *saving = [mySavingArr objectAtIndex:indexPath.row];
        
        cell.lblTitle.text = [NSString stringWithFormat:@"%@",[saving valueForKey:@"CategoryName"]];
        cell.lblAmount.text = [NSString stringWithFormat:@"%@",[saving valueForKey:@"amount"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
    else
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExpenseCell" owner:self options:nil];
        ExpenseCell *cell = [nib objectAtIndex:0];
        NSDictionary *expense = [myExpenseArr objectAtIndex:indexPath.row];
        cell.lblDate.text = [NSString stringWithFormat:@"%@",[expense valueForKey:@"ExpenseDate"]];
        cell.lblAmount.text = [NSString stringWithFormat:@"%@",[expense valueForKey:@"Amount"]];
        cell.lblDesc.text = [NSString stringWithFormat:@"%@",[expense valueForKey:@"Description"]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self performSegueWithIdentifier:@"financeList_to_Details" sender:self];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100)
    {
        return 60;
    }
    else
    {
        return 100;
    }
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        baseViewRect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width-124);
        self.budgetView.frame=baseViewRect;
        self.expenseView.frame=baseViewRect;
        self.settingsView.frame=baseViewRect;
        [self setupBudgetPieView];
 }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        baseViewRect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-124);
        self.budgetView.frame=baseViewRect;
        self.expenseView.frame=baseViewRect;
        self.settingsView.frame=baseViewRect;
        [self setupBudgetPieView];

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)action_Budget:(UIButton *)sender
{
    [self resetTabBar];
    [self resetViews];
    self.lblBudget.textColor=THEME_COLOR;
    self.imgbudget.tintColor=THEME_COLOR;
    self.budgetView.frame=baseViewRect;
    [self.baseView addSubview:self.budgetView];

}

- (IBAction)action_Expense:(UIButton *)sender
{
    [self resetTabBar];
    [self resetViews];
    self.lblExpense.textColor=THEME_COLOR;
    self.imgExpense.tintColor=THEME_COLOR;
    self.expenseView.frame=baseViewRect;
    [self.baseView addSubview:self.expenseView];

}

- (IBAction)action_Settings:(UIButton *)sender
{
    [self resetTabBar];
    [self resetViews];
    self.lblSetting.textColor=THEME_COLOR;
    self.imgSetting.tintColor=THEME_COLOR;
    self.settingsView.frame=baseViewRect;
    [self.baseView addSubview:self.settingsView];

}

- (IBAction)action_MyBudget:(UIButton *)sender
{
    [self.btnMyBudget setBackgroundColor:THEME_COLOR];
    [self.btnMySavings setBackgroundColor:[UIColor lightGrayColor]];

    [self.myBudgetView setHidden:NO];
    [self.mySavingView setHidden:YES];

}

- (IBAction)action_MySavings:(UIButton *)sender
{
    [self.btnMyBudget setBackgroundColor:[UIColor lightGrayColor]];
    [self.btnMySavings setBackgroundColor:THEME_COLOR];

    [self.myBudgetView setHidden:YES];
    [self.mySavingView setHidden:NO];
}
- (IBAction)action_AddExpense:(UIButton *)sender
{
    
}

-(void)resetViews
{
    [self.budgetView removeFromSuperview];
    [self.expenseView removeFromSuperview];
    [self.settingsView removeFromSuperview];
}

-(void)resetTabBar
{
    self.lblBudget.textColor=DARK_BG;
    self.lblExpense.textColor=DARK_BG;
    self.lblSetting.textColor=DARK_BG;
    self.imgbudget.tintColor=DARK_BG;
    self.imgExpense.tintColor=DARK_BG;
    self.imgSetting.tintColor=DARK_BG;

}
- (IBAction)action_SettingSubmit:(UIButton *)sender
{
    
}
- (IBAction)action_SettingCancel:(UIButton *)sender
{
    
}


#pragma mark - LTHMonthYearPickerView Delegate
- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues {
    _txtSelectMonth.text = [NSString stringWithFormat:
                           @"%@ / %@",
                           initialValues[@"month"],
                           initialValues[@"year"]];
    [_txtSelectMonth resignFirstResponder];
}


- (void)pickerDidPressDoneWithMonth:(NSString *)month andYear:(NSString *)year {
    _txtSelectMonth.text = [NSString stringWithFormat: @"%@-%@", month, year];
    [_txtSelectMonth resignFirstResponder];
}


- (void)pickerDidPressCancel {
    [_txtSelectMonth resignFirstResponder];
}


- (void)pickerDidSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"row: %zd in component: %zd", row, component);
}


- (void)pickerDidSelectMonth:(NSString *)month {
    NSLog(@"month: %@ ", month);
}


- (void)pickerDidSelectYear:(NSString *)year {
    NSLog(@"year: %@ ", year);
}


- (void)pickerDidSelectMonth:(NSString *)month andYear:(NSString *)year {
    _txtSelectMonth.text = [NSString stringWithFormat: @"%@-%@", month, year];
    [self setupBudgetView:[NSString stringWithFormat: @"%@-%@", month, year]];
    [self setupExpenseApi:[NSString stringWithFormat: @"%@-%@", month, year]];

}

@end
