//
//  InsuranceReportVC.m
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "InsuranceReportVC.h"
#import "InsuranceReportCell.h"
#import "ViewHomeInsVC.h"
#import "ViewHealthInsVC.h"
#import "ViewCarAccident.h"
@interface InsuranceReportVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *accreportArr;
    UILabel *nodata;
    NSMutableDictionary *selectedDic;

}
@end

@implementation InsuranceReportVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Insurance Report"];

    self.lblBtn.layer.cornerRadius=self.lblBtn.bounds.size.height/2;
    self.lblBtn.clipsToBounds=YES;
    self.tblReport.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tblReport reloadData];
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    selectedDic =[[NSMutableDictionary alloc]init];
    if (self.type==1)
    {
        // [self.btnReport setTitle:[TSLanguageManager localizedString:@"Report New Accident"] forState:UIControlStateNormal];
        self.lblBtn.text=[TSLanguageManager localizedString:@"Report New Accident"];
        
        
        [self api_GetCarAccidentReport];
    }
    
    if (self.type==2)
    {
        // [self.btnReport setTitle:[TSLanguageManager localizedString:@"Send New Request"] forState:UIControlStateNormal];
        self.lblBtn.text=[TSLanguageManager localizedString:@"Send New Request"];
        
        [self api_GetHealthAccidentReport];
        
    }
    
    if (self.type==3)
    {
        // [self.btnReport setTitle:[TSLanguageManager localizedString:@"Send New Request"] forState:UIControlStateNormal];
        self.lblBtn.text=[TSLanguageManager localizedString:@"Send New Request"];
        
        [self api_GetHomeAccidentReport];
        
    }

    
}

-(void)api_GetCarAccidentReport
{
    
    [General startLoader:self.view];

   
    
    
APIHandler *api=[[APIHandler alloc]init];
    
    [api api_GetCarAccidentReport:^(id result)
    {
        @try
        {
            accreportArr=[result valueForKey:@"data"];
            if (accreportArr.count>0)
            {
                [nodata removeFromSuperview];
            }
            else
            {
                [self.tblReport addSubview:nodata];
                
            }
            [self.tblReport reloadData];
        }
        @catch (NSException *exception)
        {
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
            
        }
        [General stopLoader];
        
        
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        
    }];
}
-(void)api_GetHealthAccidentReport
{
    
    [General startLoader:self.view];

    
    
    
APIHandler *api=[[APIHandler alloc]init];
    
    [api api_GetHealthAccidentReport:^(id result)
     {
         @try
         {
             accreportArr=[result valueForKey:@"data"];
             if (accreportArr.count>0)
             {
                 [nodata removeFromSuperview];
             }
             else
             {
                 [self.tblReport addSubview:nodata];
                 
             }
             [self.tblReport reloadData];
         }
         @catch (NSException *exception)
         {
             [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             
         }
         [General stopLoader];
         
         
     }
                          failure:^(NSURLSessionTask *operation, NSError *error)
     {
         
     }];
}
-(void)api_GetHomeAccidentReport
{
    
    [General startLoader:self.view];

    
    
 APIHandler *api=[[APIHandler alloc]init];
    
    [api api_GetHomeAccidentReport:^(id result)
     {
         
         @try
         {
             accreportArr=[result valueForKey:@"data"];
             if (accreportArr.count>0)
             {
                 [nodata removeFromSuperview];
             }
             else
             {
                 [self.tblReport addSubview:nodata];
                 
             }
             [self.tblReport reloadData];
         }
         @catch (NSException *exception)
         {
             [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             
         }
         [General stopLoader];

         
     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         
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


#pragma mark - TableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return accreportArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InsuranceReportCell" owner:self options:nil];
    InsuranceReportCell *cell = [nib objectAtIndex:0];
    NSDictionary *dic = [accreportArr objectAtIndex:indexPath.row];

    cell.btnView.layer.cornerRadius=cell.btnView.bounds.size.height/2;
    cell.btnView.clipsToBounds=YES;
    cell.policylbl.text=[TSLanguageManager localizedString:@"Policy No"];
    cell.datelbl.text=[TSLanguageManager localizedString:@"Report Date"];

    cell.lblPolicyNum.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"PolicyNo"]];
    cell.lblDate.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"ReportedDate"]];
    [cell.btnView setTitle:[TSLanguageManager localizedString:@"View"] forState:UIControlStateNormal];
    cell.btnView.userInteractionEnabled=NO;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedDic = [accreportArr objectAtIndex:indexPath.row];
    if (self.type==1)
    {
        [self performSegueWithIdentifier:@"report_to_viewCarDoc" sender:self];
    }
    
    if (self.type==2)
    {
        [self performSegueWithIdentifier:@"report_to_viewHealth" sender:self];
    }
    
    if (self.type==3)
    {
        [self performSegueWithIdentifier:@"report_to_viewHome" sender:self];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (IBAction)action_Report:(UIButton *)sender
{
    [General stopLoader];

    if (self.type==1)
    {
        [self performSegueWithIdentifier:@"report_to_addCarDoc" sender:self];
    }
    
    if (self.type==2)
    {
        [self performSegueWithIdentifier:@"report_to_addHealth" sender:self];
    }
    
    if (self.type==3)
    {
        [self performSegueWithIdentifier:@"report_to_addHome" sender:self];
    }    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"report_to_viewCarDoc"])
    {
        ViewCarAccident *obj = [segue destinationViewController];
        obj.selectedDic = selectedDic;
    }
    if ([[segue identifier] isEqualToString:@"report_to_viewHealth"])
    {
        ViewHealthInsVC *obj = [segue destinationViewController];
        obj.selectedDic = selectedDic;
    }
    if ([[segue identifier] isEqualToString:@"report_to_viewHome"])
    {
        ViewHomeInsVC *obj = [segue destinationViewController];
        obj.selectedDic = selectedDic;
    }
}
- (IBAction)action_Menu:(UIButton *)sender
{
    //[self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (IBAction)action_Back:(UIButton *)sender
{
    if( [self navigationController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
    
}
@end
