//
//  InsuranceReportVC.m
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "InsuranceReportVC.h"
#import "InsuranceReportCell.h"
@interface InsuranceReportVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation InsuranceReportVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.btnReport.layer.cornerRadius=self.btnReport.bounds.size.height/2;
    self.btnReport.clipsToBounds=YES;
    self.tblReport.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tblReport reloadData];
    
    if (self.type==1)
    {
        [self.btnReport setTitle:@"Report New Accident" forState:UIControlStateNormal];
    }
    
    if (self.type==2)
    {
        [self.btnReport setTitle:@"Send New Request" forState:UIControlStateNormal];
    }
    
    if (self.type==3)
    {
        [self.btnReport setTitle:@"Send New Request" forState:UIControlStateNormal];
    }
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
    return 6;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InsuranceReportCell" owner:self options:nil];
    InsuranceReportCell *cell = [nib objectAtIndex:0];
    cell.btnView.layer.cornerRadius=cell.btnView.bounds.size.height/2;
    cell.btnView.clipsToBounds=YES;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
