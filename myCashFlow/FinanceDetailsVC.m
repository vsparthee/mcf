//
//  FinanceDetailsVC.m
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "FinanceDetailsVC.h"
#import "FinanceFurtherInfo.h"
#import "DocListCell.h"
@interface FinanceDetailsVC ()
{
    NSArray *pdfArr;
}
@end

@implementation FinanceDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Finance Folder"];
    self.lblPolicynum.text=[TSLanguageManager localizedString:@"Policy Number"];
    self.lblstartdate.text=[TSLanguageManager localizedString:@"Start Date"];
    self.lblenddate.text=[TSLanguageManager localizedString:@"End Date"];
    self.lblpremium.text=[TSLanguageManager localizedString:@"Annual Premium"];
    self.lblcategory.text=[TSLanguageManager localizedString:@"Category"];
    self.lbltenure.text=[TSLanguageManager localizedString:@"Tenure"];
    [self.btnFurtherInfo setTitle:[TSLanguageManager localizedString:@"Further Information"] forState:UIControlStateNormal];

    
    
    
    
    self.lblTenure.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"Tenure"]];
    self.lblEndDate.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"EndDate"]];
    self.lblStartDate.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"StartDate"]];
    self.lblPolicyNum.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"PolicyNo"]];
    self.lblCategory.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"Type"]];
    self.lblPremiumAmt.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"Premium"]];
    self.lblInsuranceTitle.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"ProductName"]];
    self.lblInsuranceType.text = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"Type"]];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];

    self.lblProfileName.text = [NSString stringWithFormat:@"%@ %@",[userInfo valueForKey:@"Firstname"],[userInfo valueForKey:@"Lastname"]];
    
    NSString *strURL = [NSString stringWithFormat:@"%@",[self.selectedFinance valueForKey:@"CompanyLogo"]];
    NSURL *url = [NSURL URLWithString:strURL];
    [self.imgProfile setShowActivityIndicatorView:YES];
    [self.imgProfile setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgProfile sd_setImageWithURL:url
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    pdfArr=[self.selectedFinance valueForKey:@"DocumentList"];
    
    if (pdfArr.count>0)
    {
        self.btnPDF.alpha=1.0;
        self.btnPDF.userInteractionEnabled=YES;
    }
    else
    {
        self.btnPDF.alpha=0.6;
        self.btnPDF.userInteractionEnabled=NO;
    }
    self.tblDocList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tblDocList reloadData];

    // Do any additional setup after loading the view.
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
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    }
}
- (IBAction)action_FurtherInfo:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"Detail_to_FurtherInfo" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Detail_to_FurtherInfo"])
    {
        FinanceDetailsVC *obj = [segue destinationViewController];
        obj.selectedFinance = self.selectedFinance;
    }
}

- (IBAction)action_PDF:(UIButton *)sender
{
    self.docView.frame=[UIScreen mainScreen].bounds;
    [self.view addSubview:self.docView];
}
- (IBAction)action_CloseDoc:(UIButton *)sender {
    
    [self.docView removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   return pdfArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DocListCell" owner:self options:nil];
    DocListCell *cell = [nib objectAtIndex:0];
    NSDictionary *finance = [pdfArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"FileName"]];
    [cell.btndownload addTarget:self action:@selector(viewPDF:) forControlEvents:UIControlEventTouchUpInside];
    cell.btndownload.tag=indexPath.row;

    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}

-(IBAction)viewPDF:(UIButton*)sender
{
    NSDictionary *tax = [pdfArr objectAtIndex:sender.tag];
    
    PdfViewerVC  *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PdfViewerVC"];
    wc.urlStr=[NSString stringWithFormat:@"%@",[tax valueForKey:@"URL"]];
    [self presentViewController:wc animated:YES completion:nil];
}

@end
