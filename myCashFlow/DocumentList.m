//
//  DocumentList.m
//  myCashFlow
//
//  Created by Rishi on 10/7/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "DocumentList.h"
#import "DocListCell.h"
@interface DocumentList ()
{
    NSMutableArray *pdfArr;
    UILabel *nodata;

}
@end

@implementation DocumentList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Documents"];

    self.tblDocList.separatorStyle = UITableViewCellSeparatorStyleNone;
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = @"Please Wait";
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:THEME_FONT size:16];
    nodata.textColor = DARK_BG;
    APIHandler *api=[[APIHandler alloc]init];
    [self.tblDocList addSubview:nodata];

    [General startLoader:self.view];

    [api api_Documents:^(id result)
    {
        pdfArr=[result valueForKey:@"data"];
        if (pdfArr.count>0)
        {
            [nodata removeFromSuperview];
        }
        else
        {
            nodata.text = @"No data founds in Document List";
        }
        [self.tblDocList reloadData];
        self.tblDocList.estimatedRowHeight = 200;
        self.tblDocList.rowHeight = 200;
        self.tblDocList.rowHeight = UITableViewAutomaticDimension;
        [General stopLoader];

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return pdfArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DocListCell" owner:self options:nil];
    DocListCell *cell = [nib objectAtIndex:0];
    NSDictionary *doc = [pdfArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[doc valueForKey:@"DocumentTitle"]];
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
