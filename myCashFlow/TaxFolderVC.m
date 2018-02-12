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
#import "DocListCell.h"
@interface TaxFolderVC ()<HVTableViewDelegate,HVTableViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *taxArr,*pdfArr;
    UILabel *nodata;
}

@end

@implementation TaxFolderVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btnAppointment setTitle:[TSLanguageManager localizedString:@"Click to Book Appointment"] forState:UIControlStateNormal];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Tax Folder"];

    self.tblTax.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblTax.HVTableViewDelegate = self;
    self.tblTax.HVTableViewDataSource = self;

    self.tblTax.expandOnlyOneCell = true;
    self.tblTax.enableAutoScroll = true;
    self.tblTax.estimatedRowHeight = 2500;
    self.tblTax.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);

    self.tblDocList.delegate = self;
    self.tblDocList.dataSource = self;
    [self setupAPI];
    
}

-(void)setupAPI
{
    
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found in Tax Folder"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;
    
    [General startLoader:self.view];
    
    
    
    APIHandler *api = [[APIHandler alloc]init];
    [api api_taxFolder:^(id result)
     {
         @try
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
    
    /*
    cell.questionView.backgroundColor = theme_color;
    [UIView animateWithDuration:.5 animations:^{
        NSMutableDictionary *dic = (NSMutableDictionary*)[self.otherPgmArr objectAtIndex:indexPath.row];
        NSString *date = [GeneralVC MMMM_dd_yyyy_dateConvertor:[dic valueForKey:@"progStartDate"]];
        date = [date stringByAppendingString:[NSString stringWithFormat:@"  %@",[GeneralVC convertTimeFromMileSecond:[dic valueForKey:@"progStartTime"]]]];
        cell.questionLbl.text = date;
        cell.img.hidden = NO;
        
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
        
    }];
     */
}

-(void)tableView:(UITableView *)tableView collapseCell:(TaxFolderCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
   /* 
    cell.questionView.backgroundColor = theme_color;
    
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
    
    if (tableView.tag == 100)
    {
        return taxArr.count;
    }
    else
    {
        return pdfArr.count;
    }
    
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
        
        if (!([[tax valueForKey:@"Status"]rangeOfString:@"done" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            cell.lblStatus.backgroundColor = [UIColor colorWithRed:0.00 green:0.90 blue:0.46 alpha:1.0];
        }
    NSMutableArray *temparr = [[tax valueForKey:@"FileList"] mutableCopy];
    
    if (temparr.count>0)
    {
        [cell.btndownload addTarget:self action:@selector(viewPDF:) forControlEvents:UIControlEventTouchUpInside];
        cell.btndownload.tag=indexPath.row;
        cell.btndownload.alpha = 1.0;
        cell.viewpdflbl.alpha = 1.0;
        cell.docimage.alpha = 1.0;
        cell.btndownload.userInteractionEnabled=YES;
    }
    else
    {
        cell.btndownload.alpha = 0.4;
        cell.viewpdflbl.alpha = 0.4;
        cell.docimage.alpha = 0.4;
        cell.btndownload.userInteractionEnabled=NO;
    }

   // [cell.btndownload addTarget:self action:@selector(viewPDF:) forControlEvents:UIControlEventTouchUpInside];
  //  cell.btndownload.tag=indexPath.row;

        cell.yrlbl.text=[TSLanguageManager localizedString:@"Tax Year"];
        cell.filldatelbl.text=[TSLanguageManager localizedString:@"Tax Filling Date"];
        cell.viewpdflbl.text=[TSLanguageManager localizedString:@"View PDF"];
        cell.doclbl.text=[TSLanguageManager localizedString:@"Document List"];
        
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DocListCell" owner:self options:nil];
    DocListCell *cell = [nib objectAtIndex:0];
    NSDictionary *finance = [pdfArr objectAtIndex:indexPath.row];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"filename"]];
    [cell.btndownload addTarget:self action:@selector(openPDF:) forControlEvents:UIControlEventTouchUpInside];
    cell.btndownload.tag=indexPath.row;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}
-(IBAction)viewPDF:(UIButton*)sender
{

    self.docView.frame=[UIScreen mainScreen].bounds;
    [self.view addSubview:self.docView];

    
    NSDictionary *tax = [taxArr objectAtIndex:sender.tag];
    
    pdfArr = [[tax valueForKey:@"FileList"] mutableCopy];
    
    [self.tblDocList reloadData];

    
}

-(IBAction)openPDF:(UIButton*)sender
{
    
    NSDictionary *tax = [pdfArr objectAtIndex:sender.tag];
    
    PdfViewerVC  *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PdfViewerVC"];
    
    //wc.urlStr=[NSString stringWithFormat:@"www.inkwelleditorial.com/pdfSample.pdf"];
    wc.titleStr=[NSString stringWithFormat:@"%@",[tax valueForKey:@"filename"]];
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
- (IBAction)action_Appointment:(UIButton *)sender
{
    [General startLoader:self.view];
    APIHandler *api = [[APIHandler alloc]init];
    [api api_taxAppoinment:^(id result)
    {
        @try
        {
            if ([[result valueForKey:@"status"] boolValue]==true)
            {
                [General makeToast:[TSLanguageManager localizedString:@"Your appoinment registered successfully"] withToastView:self.view];
            }
            else
            {
                [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
            }

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

- (IBAction)action_CloseDoc:(UIButton *)sender
{
    [self.docView removeFromSuperview];
}

@end
