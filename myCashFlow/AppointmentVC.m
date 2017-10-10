//
//  AppointmentVC.m
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AppointmentVC.h"
#import "AppoinmentCell.h"
@interface AppointmentVC ()
{
    NSMutableArray *appoinmentArr;
    UILabel *nodata;
    int height;
    
}
@end

@implementation AppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Make Appointment"];

    self.tblAppointment.estimatedRowHeight = 2500;
    self.tblAppointment.rowHeight = 200;
    self.tblAppointment.rowHeight = UITableViewAutomaticDimension;
    self.tblAppointment.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupAPI];
    
}

-(void)setupAPI
{
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = @"No data founds in product solution";
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;

    [General startLoader:self.view];

    APIHandler *api = [[APIHandler alloc]init];
    [api api_ContractAppoinmentList:^(id result)
     {
         NSDictionary *temp =[result mutableCopy];
         appoinmentArr = [temp valueForKey:@"data"];
         if (appoinmentArr.count>0)
         {
             [nodata removeFromSuperview];
         }
         else
         {
             [self.tblAppointment addSubview:nodata];
         }
         [self.tblAppointment reloadData];
         [General stopLoader];

     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         [General stopLoader];

     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return appoinmentArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AppoinmentCell" owner:self options:nil];
    AppoinmentCell *cell = [nib objectAtIndex:0];
    NSDictionary *appoinment = [appoinmentArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[appoinment valueForKey:@"PolicyName"]];
    cell.lblType.text=[NSString stringWithFormat:@"%@",[appoinment valueForKey:@"Type"]];
    cell.lblPolicyNum.text=[NSString stringWithFormat:@"%@",[appoinment valueForKey:@"PolicyNo"]];
    cell.lblPremium.text=[NSString stringWithFormat:@"%@",[appoinment valueForKey:@"Premium"]];
    cell.lblStartDate.text=[NSString stringWithFormat:@"%@",[appoinment valueForKey:@"StartDate"]];
    cell.lblEndDate.text=[NSString stringWithFormat:@"%@",[appoinment valueForKey:@"EndDate"]];

    cell.btnBookAppointment.tag=indexPath.row;
    [cell.btnBookAppointment addTarget:self action:@selector(action_bookAppoinment:) forControlEvents:UIControlEventTouchUpInside];
    cell.policylbl.text=[TSLanguageManager localizedString:@"Policy Number"];
    cell.premiumlbl.text=[TSLanguageManager localizedString:@"Premium"];

    [cell.btnBookAppointment setTitle:[TSLanguageManager localizedString:@"Book For Renewal Appointment"] forState:UIControlStateNormal];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  250;
}


-(IBAction)action_bookAppoinment:(UIButton*)sender
{
    [General startLoader:self.view];

    NSDictionary *appoinment = [appoinmentArr objectAtIndex:sender.tag];
    NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];

    [apiDic setObject:[appoinment valueForKey:@"PolicyNo"] forKey:@"PolicyNo"];
    [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    
    APIHandler *api = [[APIHandler alloc]init];
    
    [api api_BookContractAppoinmentList:apiDic withSuccess:^(id result)
    {
        if ([[result valueForKey:@"status"] intValue]==1 )
        {
            [General makeToast:[TSLanguageManager localizedString:@"Your appointment registered successfully"] withToastView:self.view];
            
        }
        else
        {
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later" ]withToastView:self.view];
        }
        [General stopLoader];

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];

    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
