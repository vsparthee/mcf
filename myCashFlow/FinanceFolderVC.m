//
//  FinanceFolderVC.m
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "FinanceFolderVC.h"
#import "FinanceFolderCell.h"
#import "FinanceDetailsVC.h"
@interface FinanceFolderVC ()
{
    NSMutableArray *financeArr;
    NSMutableDictionary *selectedFinance;
    UILabel *nodata;
}
@end

@implementation FinanceFolderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tblPrivate.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tblPrivate.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114);
    [self.tblView addSubview:self.tblPrivate];
    self.privateView.backgroundColor = THEME_COLOR;
    [self.btnPrivate setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    [self.btnCompany setTitleColor:DARK_BG forState:UIControlStateNormal];
    self.companyView.backgroundColor = [UIColor clearColor];
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
    [api api_financeFolder:^(id result)
    {
        NSDictionary *temp= [result mutableCopy];
        financeArr=[temp valueForKey:@"data"];
        
        if (financeArr.count>0)
        {
            [nodata removeFromSuperview];
        }
        else
        {
            [self.tblPrivate addSubview:nodata];
            [self.tblCompany addSubview:nodata];
            
        }
        
        [self.tblPrivate reloadData];
        [self.tblCompany reloadData];
        [General stopLoader];
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];

    }];
   
    
   /* NSString *filePath = [[NSBundle mainBundle] pathForResource:@"financefolder" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    financeArr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    */
    
    
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
    if (tableView.tag==100)
    {
        return financeArr.count;
    }
    else
    {
        return financeArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FinanceFolderCell" owner:self options:nil];
        FinanceFolderCell *cell = [nib objectAtIndex:0];
        NSDictionary *finance = [financeArr objectAtIndex:indexPath.row];
        
        cell.lblTitle.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"ProductName"]];
        cell.lblType.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Type"]];
        cell.lblAmount.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Premium"]];
        cell.lblTenure.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Tenure"]];
        NSString *strURL = [NSString stringWithFormat:@"%@",[finance valueForKey:@"CompanyLogo"]];
        NSURL *url = [NSURL URLWithString:strURL];
        [cell.imgLogo setShowActivityIndicatorView:YES];
        [cell.imgLogo setIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.imgLogo sd_setImageWithURL:url
                        placeholderImage:nil
                                 options:SDWebImageRefreshCached];    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FinanceFolderCell" owner:self options:nil];
        FinanceFolderCell *cell = [nib objectAtIndex:0];
        NSDictionary *finance = [financeArr objectAtIndex:indexPath.row];
        
        cell.lblTitle.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"ProductName"]];
        cell.lblType.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Type"]];
        cell.lblAmount.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Premium"]];
        cell.lblTenure.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Tenure"]];
        NSString *strURL = [NSString stringWithFormat:@"%@",[finance valueForKey:@"CompanyLogo"]];
        NSURL *url = [NSURL URLWithString:strURL];
        [cell.imgLogo setShowActivityIndicatorView:YES];
        [cell.imgLogo setIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.imgLogo sd_setImageWithURL:url
                        placeholderImage:nil
                                 options:SDWebImageRefreshCached];    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100)
    {
        selectedFinance = [financeArr objectAtIndex:indexPath.row];
    }
    else
    {
        selectedFinance = [financeArr objectAtIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"financeList_to_Details" sender:self];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  117.5;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"financeList_to_Details"])
    {
        FinanceDetailsVC *obj = [segue destinationViewController];
        obj.selectedFinance = selectedFinance;
    }
}


- (IBAction)action_Private:(UIButton *)sender
{
    self.tblPrivate.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114);
    [self.tblView addSubview:self.tblPrivate];
    self.privateView.backgroundColor = THEME_COLOR;
    self.companyView.backgroundColor = [UIColor clearColor];
    [self.btnPrivate setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    [self.btnCompany setTitleColor:DARK_BG forState:UIControlStateNormal];

    [self.tblCompany removeFromSuperview];

}

- (IBAction)action_Company:(UIButton *)sender
{
    self.tblCompany.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114);
    [self.tblView addSubview:self.tblCompany];
    self.privateView.backgroundColor = [UIColor clearColor];
    self.companyView.backgroundColor = THEME_COLOR;
    [self.btnPrivate setTitleColor:DARK_BG forState:UIControlStateNormal];
    [self.btnCompany setTitleColor:THEME_COLOR forState:UIControlStateNormal];

    [self.tblPrivate removeFromSuperview];
}
@end
