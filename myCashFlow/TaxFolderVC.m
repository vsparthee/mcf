//
//  TaxFolderVC.m
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "TaxFolderVC.h"
#import "TaxFolderCell.h"
#import "HVTableView.h"
@interface TaxFolderVC ()<HVTableViewDelegate,HVTableViewDataSource>
{
    NSMutableArray *taxArr;
    UILabel *nodata;
}

@end

@implementation TaxFolderVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblTax.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblTax.HVTableViewDelegate = self;
    self.tblTax.HVTableViewDataSource = self;
    self.tblTax.expandOnlyOneCell = true;
    self.tblTax.enableAutoScroll = true;
    self.tblTax.estimatedRowHeight = 2500;
    self.tblTax.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);

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
    [api api_taxFolder:^(id result)
     {
         NSDictionary *temp =[result mutableCopy];
         taxArr = [temp valueForKey:@"data"];
         if (taxArr.count>0)
         {
             [nodata removeFromSuperview];
         }
         else
         {
             [self.tblTax addSubview:nodata];
             
         }
         
         [self.tblTax reloadData];
         [General stopLoader];
     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         [General stopLoader];

     }];
    
    
    /*NSString *filePath = [[NSBundle mainBundle] pathForResource:@"financefolder" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    taxArr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];*/
    
    
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

#pragma Mark - Expandable Uitableview

-(void)tableView:(UITableView *)tableView expandCell:(TaxFolderCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:.5 animations:^{
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
    }];
    
    /*cell.questionView.backgroundColor = theme_color;
    [UIView animateWithDuration:.5 animations:^{
        NSMutableDictionary *dic = (NSMutableDictionary*)[self.otherPgmArr objectAtIndex:indexPath.row];
        NSString *date = [GeneralVC MMMM_dd_yyyy_dateConvertor:[dic valueForKey:@"progStartDate"]];
        date = [date stringByAppendingString:[NSString stringWithFormat:@"  %@",[GeneralVC convertTimeFromMileSecond:[dic valueForKey:@"progStartTime"]]]];
        cell.questionLbl.text = date;
        cell.img.hidden = NO;
        
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
        
    }];*/
}

-(void)tableView:(UITableView *)tableView collapseCell:(TaxFolderCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
   /* cell.questionView.backgroundColor = theme_color;
    
    NSMutableDictionary *dic = (NSMutableDictionary*)[self.otherPgmArr objectAtIndex:indexPath.row];
    NSString *date = [GeneralVC MMMM_dd_yyyy_dateConvertor:[dic valueForKey:@"progStartDate"]];
    date = [date stringByAppendingString:[NSString stringWithFormat:@"  %@",[GeneralVC convertTimeFromMileSecond:[dic valueForKey:@"progStartTime"]]]];
    cell.questionLbl.text = date;
        cell.img.hidden = YES;
        */
    cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);

    [UIView animateWithDuration:0.5 animations:^{
        
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(-M_PI+0.00);
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return taxArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TaxFolderCell" owner:self options:nil];
    TaxFolderCell *cell = [nib objectAtIndex:0];
    NSDictionary *tax = [taxArr objectAtIndex:indexPath.row];

    if (!isExpanded)
    {
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }
    else
    {
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
    }
    cell.lblTaxYear.text=[NSString stringWithFormat:@"%@",[tax valueForKey:@"TaxYear"]];
    cell.lblStatus.text=[NSString stringWithFormat:@"%@",[tax valueForKey:@"Status"]];
    cell.lblFilingDate.text=[NSString stringWithFormat:@"%@",[tax valueForKey:@"TaxFillingDate"]];
    
    [cell.btndownload addTarget:self action:@selector(viewPDF:) forControlEvents:UIControlEventTouchUpInside];
    cell.btndownload.tag=indexPath.row;
     
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
    if(isexpanded)
    {
        return  UITableViewAutomaticDimension;
    }
    
    else
    {
        return 90;
    }
}

-(IBAction)viewPDF:(UIButton*)sender
{
    NSDictionary *tax = [taxArr objectAtIndex:sender.tag];

    PdfViewerVC  *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PdfViewerVC"];
    
    //wc.urlStr=[NSString stringWithFormat:@"www.inkwelleditorial.com/pdfSample.pdf"];
    wc.urlStr=[NSString stringWithFormat:@"%@",[tax valueForKey:@"URL"]];
    [self presentViewController:wc animated:YES completion:nil];
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
