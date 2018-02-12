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
#import "MyBudgetCell.h"
#import "BudgetSettingCell.h"
@interface BudgetAndSaveRateVC ()<UITextFieldDelegate,LTHMonthYearPickerViewDelegate>
{
    CGRect baseViewRect;
    NSMutableArray *mySavingArr,*pieChartArr,*budgetArr,*myExpenseArr,*newArr,*settingArr,*budgetArrTbl;
    NSMutableDictionary *settingDic;
    int total;
    UIDatePicker *datePicker;
    UIBarButtonItem *rightBtn;
    float height;
    UILabel *nodata;
    BOOL isEdit;

}
@property (nonatomic, strong) LTHMonthYearPickerView *monthYearPicker;

@end

@implementation BudgetAndSaveRateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isEdit = NO;
    self.tblBudget.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblExpense.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblSavings.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblSetting.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblSetting.estimatedRowHeight = 2500;
    self.tblSetting.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    self.tblSetting.rowHeight = UITableViewAutomaticDimension;

    [self.tblBudget setContentOffset:self.tblBudget.contentOffset animated:NO];
    /*self.lblExp.text=[TSLanguageManager localizedString:@"Please Wait..."];
    self.lblMyBudget.text=[TSLanguageManager localizedString:@"Please Wait..."];
    self.lblSaving.text=[TSLanguageManager localizedString:@"Please Wait..."];
*/
    self.txtSettingName.layer.borderColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0].CGColor;
    self.txtSettingName.layer.borderWidth = 1.0f;
    self.txtSettingName.layer.cornerRadius = 5;
    self.txtSettingName.clipsToBounds = YES;
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found in Tax Folder"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;

    self.lblMyBudget.hidden=YES;
    self.lblSaving.hidden=YES;
    self.lblExp.hidden=YES;

    [self.btnExpense setTitle:[TSLanguageManager localizedString:@"Add New Expense"] forState:UIControlStateNormal];
    [self.btnMyBudget setTitle:[TSLanguageManager localizedString:@"My Budgets"] forState:UIControlStateNormal];
    [self.btnMySavings setTitle:[TSLanguageManager localizedString:@"My Savings"] forState:UIControlStateNormal];
    [self.btnSettingCancel setTitle:[TSLanguageManager localizedString:@"Cancel"] forState:UIControlStateNormal];
    [self.btnSettingSubmit setTitle:[TSLanguageManager localizedString:@"Submit"] forState:UIControlStateNormal];
    [self.btnAdd setTitle:[TSLanguageManager localizedString:@"Add"] forState:UIControlStateNormal];

    self.earnlbl.text=[TSLanguageManager localizedString:@"Total Earning"];
    self.rentlbl.text=[TSLanguageManager localizedString:@"House Rent"];
    self.insurancelbl.text=[TSLanguageManager localizedString:@"Insurance"];
    self.taxlbl.text=[TSLanguageManager localizedString:@"Tax"];
    self.expenselbl.text=[TSLanguageManager localizedString:@"Daily Expense"];
    self.titlelbl.text=[TSLanguageManager localizedString:@"Budget and Saverate"];
    self.lblSetting.text=[TSLanguageManager localizedString:@"Setting"];
    self.lblExpense.text=[TSLanguageManager localizedString:@"Daily Expense"];
    self.lblBudget.text=[TSLanguageManager localizedString:@"Budget&Save"];
    self.lblTitle.text=[TSLanguageManager localizedString:@"Title"];
    self.lblValue.text=[TSLanguageManager localizedString:@"Value"];

    
    baseViewRect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-124);
    self.budgetView.frame=baseViewRect;
    [self.baseView addSubview:self.budgetView];
    self.lblBudget.textColor=THEME_COLOR;
    self.imgbudget.tintColor=THEME_COLOR;
    
    
    [self.btnMyBudget setBackgroundColor:THEME_COLOR];
    [self.btnMySavings setBackgroundColor:[UIColor lightGrayColor]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-yyyy";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    self.txtSelectMonth.text=dateStr;
    self.txtSelectMonthExpence.text=dateStr;

    [self setupBudgetView:dateStr];
    [self setupExpenseApi:dateStr];

    self.txtSelectMonth.delegate=self;
    self.txtSelectMonthExpence.delegate=self;

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
    [self.txtSelectMonth setInputView:_monthYearPicker];
    [_txtSelectMonth becomeFirstResponder];
    
    [self.txtSelectMonthExpence setInputView:_monthYearPicker];
   // [_txtSelectMonthExpence becomeFirstResponder];

    _monthYearPicker.backgroundColor=BG_COLOR;
    [self setupSettingsApi];
}


- (IBAction)action_SelectMonth:(UIButton *)sender
{
    [_txtSelectMonth becomeFirstResponder];
    [_txtSelectMonthExpence becomeFirstResponder];


}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:self.txtSelectMonth]||[textField isEqual:self.txtSelectMonthExpence])
    {
        return NO;
    }
    return YES;
}
-(void)setupBudgetView:(NSString*)datestr
{
    [General startLoader:self.view];
    total=0;
    /*self.lblMyBudget.text=[TSLanguageManager localizedString:@"Please Wait..."];
    self.lblSaving.text=[TSLanguageManager localizedString:@"Please Wait..."];
    self.lblMyBudget.hidden=NO;
    self.lblSaving.hidden=NO;*/
    [self.pieChartbase setHidden:YES];
    [self.legendbase setHidden:YES];

    pieChartArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    [apiDic setObject:datestr forKey:@"selectedMonth"];
    
  
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_MyBudget: apiDic withSuccess:^(id result)
     {
         @try
         {
             budgetArr=[[NSMutableArray alloc]init];
             mySavingArr=[[NSMutableArray alloc]init];
             budgetArr = [[result valueForKey:@"MyBudget"] mutableCopy];
             budgetArrTbl = [[result valueForKey:@"MyBudget"] mutableCopy];

             if (budgetArr.count>0)
             {
                 [budgetArr removeObjectAtIndex:0];
             }
             mySavingArr = [[result valueForKey:@"MySaving"] mutableCopy];
             [self setupBudgetPieView];
             [_txtSelectMonth setUserInteractionEnabled:YES];
             [_txtSelectMonthExpence setUserInteractionEnabled:YES];
             [General stopLoader];


         }
         @catch (NSException *exception)
         {
             [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             
         }
         [General stopLoader];
        

     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         [General stopLoader];
     }];
    
}

-(void)setupBudgetPieView
{
    newArr = [[NSMutableArray alloc]init];

    if (budgetArr.count>0)
    {

        for (int i = 0; i < budgetArr.count; i++)
        {
            NSDictionary *temp = [budgetArr objectAtIndex:i];
            NSString *amt = [temp valueForKey:@"amount"];
            NSString * newString = [amt stringByReplacingOccurrencesOfString:@"CHF" withString:@""];
            amt=[newString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            total += [amt intValue];
        }
        self.chartView.usePercentValuesEnabled = YES;
        self.chartView.drawSlicesUnderHoleEnabled = NO;
        self.chartView.holeRadiusPercent = 0.48;
        self.chartView.transparentCircleRadiusPercent = 0.54;
        self.chartView.chartDescription.enabled = NO;
        [self.chartView setExtraOffsetsWithLeft:0.f top:0.f right:0.f bottom:0.f];
        
        self.chartView.drawCenterTextEnabled = YES;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSString *temp=[NSString stringWithFormat:@"%@\nCHF %d",[TSLanguageManager localizedString:@"Total"],total];

        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:temp];
        [centerText setAttributes:@{
                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:15.f],
                                    NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName: THEME_COLOR
                                    } range:NSMakeRange(0, centerText.length)];
        
        self.chartView.centerAttributedText = centerText;
        
        self.chartView.drawHoleEnabled = YES;
        self.chartView.rotationAngle = 0.0;
        self.chartView.rotationEnabled = YES;
        self.chartView.highlightPerTapEnabled = YES;

        _chartView.delegate = self;
        _chartView.entryLabelColor = UIColor.darkGrayColor;
        _chartView.entryLabelFont = [UIFont fontWithName:@"Century Gothic" size:12.f];
        [self setDataCount:(float)budgetArr.count range:100.0];
        [_chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
        
        [self.pieChartbase setHidden:NO];
        [self.legendbase setHidden:NO];
        self.tblSavings.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tblExpense.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        /*
        for (NSDictionary *dic in budgetArr)
        {
            NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
            temp = [dic mutableCopy];
            NSString *amt = [dic valueForKey:@"amount"];
            NSString * newString = [amt stringByReplacingOccurrencesOfString:@"CHF" withString:@""];
            amt=[newString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSString *color = [NSString stringWithFormat:@"%@",[self test]];
            PNPieChartDataItem *item=[PNPieChartDataItem dataItemWithValue:[amt intValue] color:[self colorFromHexString:color] description:[dic valueForKey:@"CategoryName"]];
            [temp setObject:color forKey:@"color"];
            [pieChartArr addObject:item];
            [newArr addObject:temp];

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

        
        [self.tblBudget reloadData];
        
        self.budgetheight.constant = newArr.count*60+400;
        
        [self.pieChartbase addSubview:self.pieChart];
        NSString *temp=[TSLanguageManager localizedString:@"Total"];
        self.lblTotal.text =[NSString stringWithFormat:@"%@\n%d",temp,total];
        self.lblMyBudget.hidden=YES;
         
         */
        self.lblMyBudget.hidden=YES;
        
        self.budgetheight.constant = newArr.count*60+440;

    }
    else
    {
        [self.pieChartbase setHidden:YES];
        [self.legendbase setHidden:YES];
        self.budgetheight.constant = 400;
        self.lblMyBudget.text=[TSLanguageManager localizedString:@"No data found in My Budget"];
        self.lblMyBudget.hidden=NO;


    }
  
    if (mySavingArr.count>0)
    {
        self.lblSaving.hidden=YES;
    }
    else
    {
        self.lblSaving.hidden=NO;
        self.lblSaving.text=[TSLanguageManager localizedString:@"No data found in My Savings"];
    }
    [self.tblSavings reloadData];
    [General stopLoader];

}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
        {
            baseViewRect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-124);

        }
        else
        {
            baseViewRect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width-124);

        }

        self.budgetView.frame=baseViewRect;
        self.expenseView.frame=baseViewRect;
        self.settingsView.frame=baseViewRect;
        //self.budgetheight.constant = 10*60+440;
        
        //[self setupBudgetPieView];
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        baseViewRect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width-124);
        self.budgetView.frame=baseViewRect;
        self.expenseView.frame=baseViewRect;
        self.settingsView.frame=baseViewRect;
       // self.budgetheight.constant = 10*60+440;
        
        // [self setupBudgetPieView];
        
    }
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        NSDictionary *temp = [budgetArr objectAtIndex:i];
        NSString *amt = [temp valueForKey:@"Percentage"];
      ///  NSString * newString = [amt stringByReplacingOccurrencesOfString:@"CHF" withString:@""];
        amt=[amt stringByReplacingOccurrencesOfString:@"," withString:@"."];
       // total += [amt intValue];
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[amt floatValue] label:[temp valueForKey:@"CategoryName"] icon: nil]];
    }
    
    //    for (int i = 0; i < count; i++)
    //    {
    //        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:parties[i % parties.count] icon: [UIImage imageNamed:@"icon"]]];
    //    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
    
    dataSet.drawIconsEnabled = NO;
    
    dataSet.sliceSpace = 1.0;
    dataSet.iconsOffset = CGPointMake(0, 10);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:[UIColor colorWithRed:0.96 green:0.41 blue:0.30 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.89 green:0.80 blue:0.37 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.02 green:0.48 blue:0.46 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.18 green:0.18 blue:0.25 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.40 green:0.87 blue:0.86 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.60 green:0.40 blue:1.00 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:1.00 green:0.40 blue:0.40 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.00 green:0.44 blue:1.00 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.92 green:0.35 blue:0.35 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.87 green:0.80 blue:0.64 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.25 green:0.88 blue:0.82 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.70 green:0.03 blue:0.33 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.79 green:0.44 blue:0.12 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.02 green:0.48 blue:0.46 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.18 green:0.18 blue:0.25 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.40 green:0.87 blue:0.86 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.60 green:0.40 blue:1.00 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:1.00 green:0.40 blue:0.40 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.00 green:0.44 blue:1.00 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.92 green:0.35 blue:0.35 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.87 green:0.80 blue:0.64 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.25 green:0.88 blue:0.82 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.70 green:0.03 blue:0.33 alpha:1.0]];
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @"%";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"Century Gothic" size:12.f]];
    [data setValueTextColor:UIColor.blackColor];
    
    NSLog(@"Data %f",data.yValueSum);
    _chartView.data = data;
    [_chartView highlightValues:nil];
    int i=0;
    for (NSDictionary *dic in budgetArrTbl)
    {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        temp = [dic mutableCopy];
        if (i==0)
        {
            [temp setObject:[self test:THEME_COLOR] forKey:@"color"];

        }
        else
        {
            NSString *color = [NSString stringWithFormat:@"%@",[self test:(UIColor*)colors[i-1]]];

            [temp setObject:color forKey:@"color"];

        }
        [newArr addObject:temp];
        i++;
    }
    [self.tblBudget reloadData];

}


-(NSString*)test:(UIColor*)clr
{
   /* CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];*/
    
    const CGFloat *components = CGColorGetComponents(clr.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
    // return color;
}

- (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(void)setupExpenseApi:(NSString*)datestr
{
    //self.lblExp.text=[TSLanguageManager localizedString:@"Please Wait..."];
   // self.lblExp.hidden=NO;

    NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    [apiDic setObject:datestr forKey:@"selectedMonth"];
    
    
    
    //[General startLoader:self.view];

    
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_MyBudgetDailyExpense: apiDic withSuccess:^(id result)
     {
         @try
         {
             myExpenseArr = [result valueForKey:@"data"];
             if (myExpenseArr.count>0)
             {
                 self.lblExp.hidden=YES;
             }
             else
             {
                 self.lblExp.hidden=NO;
                 self.lblExp.text=[TSLanguageManager localizedString:@"No data found in Expense"];
             }
             [self.tblExpense reloadData];

         }
         @catch (NSException *exception)
         {
             [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             
         }
         //[General stopLoader];
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
        @try
        {
            settingDic = [self CheckDictionary:[result mutableCopy]];
            settingArr = [[settingDic valueForKey:@"BudgetList"] mutableCopy];
            if (settingArr.count > 0)
            {
                self.btnEdit.hidden=NO;
                [nodata removeFromSuperview];
            }
            else
            {
                self.btnEdit.hidden=YES;
                [self.tblSetting addSubview:nodata];
            }
            [self.tblSetting reloadData];
            /*
            self.txtHouseRent.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"houserent"]];
            self.txtTax.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"tax"]];
            self.txtInsurance.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"insurance"]];
            self.txtTotalEarn.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"totalearings"]];
            self.txtDailyExpense.text=[NSString stringWithFormat:@"%@",[settingDic valueForKey:@"dailyexpenses"]];
            */
        }
        @catch (NSException *exception)
        {
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
            
        }
       

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        
    }];
    
}

-(NSMutableDictionary*)CheckDictionary:(NSMutableDictionary *)dic
{
    NSArray *Arr = [dic allKeys];
    for (int i = 0; i<Arr.count; i++)
    {
        if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSNull class]])
        {
            [dic setObject:@"" forKey:[Arr objectAtIndex:i]];
        }
        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dict = [[dic valueForKey:[Arr objectAtIndex:i]] mutableCopy];
            [dic setObject:dict forKey:[Arr objectAtIndex:i]];
            [self CheckDictionary:dict];
        }
        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSMutableArray class]])
        {
            NSMutableArray *Arr12 = [dic valueForKey:[Arr objectAtIndex:i]];
            for (int j = 0; j<Arr12.count; j++)
            {
                if ([[Arr12 objectAtIndex:j] isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *dict123 = [Arr12 objectAtIndex:j];
                    NSLog(@"dict123 : %@",dict123);
                    NSMutableDictionary *dict = [dict123 mutableCopy];
                    NSLog(@"dict123 Mutable copy : %@",dict);
                    [Arr12 replaceObjectAtIndex:j withObject:dict];
                    NSLog(@"dict123 replace : %@",[Arr12 objectAtIndex:j]);
                    [self CheckDictionary:dict];
                }
            }
        }
    }
    NSLog(@"Dic:%@",dic);
    return dic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:false];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:true];
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
    else if (tableView.tag==300)
    {
        return newArr.count;
    }
    else if (tableView.tag==400)
    {
        return settingArr.count;
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
    else if (tableView.tag==300)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyBudgetCell" owner:self options:nil];
        MyBudgetCell *cell = [nib objectAtIndex:0];
        NSDictionary *budget = [newArr objectAtIndex:indexPath.row];
        
        cell.lblTitle.text = [NSString stringWithFormat:@"%@",[budget valueForKey:@"CategoryName"]];
        cell.lblAmount.text = [NSString stringWithFormat:@"%@",[budget valueForKey:@"amount"]];
        cell.lblPercentage.text = [NSString stringWithFormat:@"%@%%",[budget valueForKey:@"Percentage"]];
        cell.lblPercentage.backgroundColor = [self colorFromHexString:[budget valueForKey:@"color"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (tableView.tag==400)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BudgetSettingCell" owner:self options:nil];
        BudgetSettingCell *cell = [nib objectAtIndex:0];
        NSDictionary *budget = [settingArr objectAtIndex:indexPath.row];
        [cell.btnDelete addTarget:self
                   action:@selector(action_Delete:)
         forControlEvents:UIControlEventTouchUpInside];
        
        cell.btnDelete.tag = indexPath.row;
        
        if (isEdit == YES && [[budget valueForKey:@"defaultValue"] boolValue] == false)
        {
            cell.lblTitle.backgroundColor = [UIColor whiteColor];
            cell.lblTitle.layer.borderColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0].CGColor;
            cell.lblTitle.editable = YES;
            cell.btnDelete.hidden=NO;
        }
        else
        {
            cell.lblTitle.backgroundColor = [UIColor clearColor];
            cell.lblTitle.layer.borderColor = [UIColor clearColor].CGColor;
            cell.lblTitle.editable = NO;
            cell.btnDelete.hidden=YES;

        }
        if (isEdit)
        {
            cell.lblAmount.userInteractionEnabled = YES;
        }
        else
        {
            cell.lblAmount.userInteractionEnabled = NO;
        }
        cell.lblTitle.layer.borderWidth = 1.0f;

        cell.lblTitle.text = [NSString stringWithFormat:@"%@",[budget valueForKey:@"Name"]];
        cell.lblAmount.text = [NSString stringWithFormat:@"%@",[budget valueForKey:@"Value"]];
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
        
        cell.datelbl.text=[TSLanguageManager localizedString:@"Date"];
        cell.desclbl.text=[TSLanguageManager localizedString:@"Description"];
        cell.amtlbl.text=[TSLanguageManager localizedString:@"Amount"];

        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
}

-(IBAction)action_Delete:(UIButton*)sender
{
    [General startLoader:self.view];
    NSDictionary *budget = [settingArr objectAtIndex:sender.tag];
    NSLog(@"%@",budget);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:[budget valueForKey:@"id"] forKey:@"id"];
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_MyBudgetDeleteEntity:dic withSuccess:^(id result)
    {
        if ([result[@"Success"] boolValue])
        {
            [settingArr removeObjectAtIndex:sender.tag];
            isEdit = NO;
            self.btnAddSetting.hidden = NO;
            self.btnEdit.hidden=NO;
            [self tableReloadWithAnimation];
            [General stopLoader];
            [self setupBudgetView:[NSString stringWithFormat:@"%@",self.txtSelectMonth.text]];
        }
        else
        {
            [General stopLoader];
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];
        [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];

    }];

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
    else if (tableView.tag==300)
    {
        return 60;
    }
    else if (tableView.tag==400)
    {
        return  UITableViewAutomaticDimension;
    }
    else
    {
        return 100;
    }
}


/*- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.budgetheight.constant=height;
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.budgetheight.constant=height-64;
        
    }
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)isEdit_Action:(UIButton *)sender
{
    isEdit = YES;
    self.btnAddSetting.hidden = YES;
    [self tableReloadWithAnimation];
    self.btnSaveSetting.hidden = NO;
    self.btnCancelSetting.hidden = NO;

   // [self.tblSetting reloadData];
    
}
-(void) tableReloadWithAnimation
{
    [UIView transitionWithView: self.tblSetting
                      duration: 0.2f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [self.tblSetting reloadData];
         [self.tblSetting setContentOffset:CGPointZero animated:YES];
     }
                    completion:^(BOOL finished) {
                    }];
    
}
- (IBAction)action_Budget:(UIButton *)sender
{
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:false];

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
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:true];

    [self resetTabBar];
    [self resetViews];
    [self setupSettingsApi];
    isEdit = NO;
    self.btnSettingSubmit.hidden = YES;
    self.btnCancelSetting.hidden = YES;
    self.btnAddSetting.hidden = NO;
    [self.addsettingsView removeFromSuperview];

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
    NSMutableArray *tempArr=[[NSMutableArray alloc]init];
    BOOL isError=NO;
    for (int i=0; i<settingArr.count; i++)
    {
        BudgetSettingCell *cell = (BudgetSettingCell *)[self.tblSetting cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        NSMutableDictionary *dic=[[settingArr objectAtIndex:i] mutableCopy];

        NSUInteger newTextLength = [cell.lblTitle.text length];
        NSUInteger newValueLength = [cell.lblAmount.text length];

        [dic removeObjectForKey:@"Name"];
        [dic removeObjectForKey:@"Value"];
        if (newTextLength>0 && newValueLength>0)
        {
            [dic setObject:[NSString stringWithFormat:@"%@",cell.lblTitle.text] forKey:@"Name"];
            [dic setObject:[NSString stringWithFormat:@"%@",cell.lblAmount.text] forKey:@"Value"];
            [tempArr addObject:dic];
        }
        else
        {
            [General makeToast:@"Fill all values before submit" withToastView:self.view];
            isError=YES;
            break;
        }
        
    }
    NSLog(@"tempArr:%@",tempArr);
    if (isError==NO)
    {
        [General startLoader:self.view];
        NSMutableDictionary *tempDic = [settingDic mutableCopy];
        [tempDic removeObjectForKey:@"BudgetList"];
        [tempDic setObject:tempArr forKey:@"BudgetList"];
        APIHandler *api = [[APIHandler alloc]init];
        settingDic = tempDic;
        settingArr = tempArr;
        

        [api api_MyBudgetSettingUpdate:tempDic withSuccess:^(id result)
         {
             self.btnSaveSetting.hidden = YES;
             self.btnCancelSetting.hidden = YES;
             [General stopLoader];
             isEdit = NO;
             [self tableReloadWithAnimation];
             self.btnAddSetting.hidden = NO;
             [self setupBudgetView:[NSString stringWithFormat:@"%@",self.txtSelectMonth.text]];



         }
         failure:^(NSURLSessionTask *operation, NSError *error)
         {
             
         }];
    }
   
}
- (IBAction)action_SettingCancel:(UIButton *)sender
{
    self.btnSaveSetting.hidden = YES;
    self.btnCancelSetting.hidden = YES;
    isEdit = NO;
    [self tableReloadWithAnimation];
    self.btnAddSetting.hidden = NO;


}

- (IBAction)action_Add:(UIButton *)sender
{
    self.txtSettingName.text = @"";
    self.txtSettingValue.text = @"";
    self.addsettingsView.frame=[UIScreen mainScreen].bounds;
    [self.view addSubview:self.addsettingsView];
}
- (IBAction)action_AddSetting:(UIButton *)sender
{
    if ([self validateRequest])
    {
        [General startLoader:self.view];
        NSMutableDictionary *tempDic = [settingDic mutableCopy];
        [tempDic removeObjectForKey:@"BudgetList"];
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        [temp setValue:[NSString stringWithFormat:@"%@",self.txtSettingName.text] forKey:@"Name"];
        [temp setValue:[NSString stringWithFormat:@"%@",self.txtSettingValue.text] forKey:@"Value"];
        [temp setValue:@"false" forKey:@"defaultValue"];
        [temp setValue:[NSNumber numberWithInteger:0] forKey:@"id"];
        NSMutableArray *tempArr = [[NSMutableArray alloc]init];
        [tempArr addObject:temp];
        [tempDic setObject:tempArr forKey:@"BudgetList"];
        APIHandler *api = [[APIHandler alloc]init];

        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempDic // Here you can pass array or dictionary
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        NSString *jsonString;
        if (jsonData) {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //This is your JSON String
            //NSUTF8StringEncoding encodes special characters using an escaping scheme
        } else {
            NSLog(@"Got an error: %@", error);
            jsonString = @"";
        }
        NSLog(@"Your JSON String is %@", jsonString);

        [api api_MyBudgetSettingUpdate:tempDic withSuccess:^(id result)
         {
             [self.addsettingsView removeFromSuperview];
             self.btnSaveSetting.hidden = YES;
             self.btnCancelSetting.hidden = YES;
             [General stopLoader];
             isEdit = NO;
             [self tableReloadWithAnimation];
             [self setupSettingsApi];
             [self setupBudgetView:[NSString stringWithFormat:@"%@",self.txtSelectMonth.text]];

         }
        failure:^(NSURLSessionTask *operation, NSError *error)
         {
             
         }];




    }
}

-(BOOL)validateRequest
{
    BOOL validation = FALSE;
    if(self.txtSettingName.text == NULL || [self.txtSettingName.text isEqualToString:@""])
    {
        CABasicAnimation *animation =
        [CABasicAnimation animationWithKeyPath:@"position"];
        [animation setDuration:0.05];
        [animation setRepeatCount:3];
        [animation setAutoreverses:YES];
        [animation setFromValue:[NSValue valueWithCGPoint:
                                 CGPointMake([self.addsettingsView center].x - 20.0f, [self.addsettingsView center].y)]];
        [animation setToValue:[NSValue valueWithCGPoint:
                               CGPointMake([self.addsettingsView center].x + 20.0f, [self.addsettingsView center].y)]];
        [[self.addsettingsView layer] addAnimation:animation forKey:@"position"];
        return validation;
    }
    else if(self.txtSettingValue.text == NULL || [self.txtSettingValue.text isEqualToString:@""])
    {
        CABasicAnimation *animation =
        [CABasicAnimation animationWithKeyPath:@"position"];
        [animation setDuration:0.05];
        [animation setRepeatCount:3];
        [animation setAutoreverses:YES];
        [animation setFromValue:[NSValue valueWithCGPoint:
                                 CGPointMake([self.addsettingsView center].x - 20.0f, [self.addsettingsView center].y)]];
        [animation setToValue:[NSValue valueWithCGPoint:
                               CGPointMake([self.addsettingsView center].x + 20.0f, [self.addsettingsView center].y)]];
        [[self.addsettingsView layer] addAnimation:animation forKey:@"position"];
        return validation;
    }
    else
    {
        validation = true;
        return validation;
    }
    return validation;
}

- (IBAction)action_CloseDoc:(UIButton *)sender
{
    [self.addsettingsView removeFromSuperview];
}


#pragma mark - LTHMonthYearPickerView Delegate
- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues {
    _txtSelectMonth.text = [NSString stringWithFormat:
                           @"%@ / %@",
                           initialValues[@"month"],
                           initialValues[@"year"]];
    [_txtSelectMonth resignFirstResponder];
    
    _txtSelectMonthExpence.text = [NSString stringWithFormat:
                            @"%@ / %@",
                            initialValues[@"month"],
                            initialValues[@"year"]];
    [_txtSelectMonthExpence resignFirstResponder];

}


- (void)pickerDidPressDoneWithMonth:(NSString *)month andYear:(NSString *)year {
    _txtSelectMonth.text = [NSString stringWithFormat: @"%@-%@", month, year];
    _txtSelectMonthExpence.text = [NSString stringWithFormat: @"%@-%@", month, year];

    [self setupBudgetView:[NSString stringWithFormat: @"%@-%@", month, year]];
    [self setupExpenseApi:[NSString stringWithFormat: @"%@-%@", month, year]];
    [_txtSelectMonth resignFirstResponder];
    [_txtSelectMonth setUserInteractionEnabled:NO];
    
    [_txtSelectMonthExpence resignFirstResponder];
    [_txtSelectMonthExpence setUserInteractionEnabled:NO];
}


- (void)pickerDidPressCancel {
    [_txtSelectMonth resignFirstResponder];
    [_txtSelectMonthExpence resignFirstResponder];

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
    _txtSelectMonthExpence.text = [NSString stringWithFormat: @"%@-%@", month, year];



}

- (IBAction)action_Setting_Delete:(UIButton *)sender {
    
    isEdit = YES;
    self.btnAddSetting.hidden = YES;
    self.btnEdit.hidden = YES;
    [self tableReloadWithAnimation];
}
@end
