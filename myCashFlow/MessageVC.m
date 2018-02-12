//
//  MessageVC.m
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "MessageVC.h"
#import "HVTableView.h"
#import "MessageCell.h"
@interface MessageVC ()<HVTableViewDelegate,HVTableViewDataSource>
{
    NSMutableArray *msgArr;
    NSMutableDictionary *selectedFinance;
    UILabel *nodata;
  
}
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Message & Notification"];

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
    [api api_Message_Notifcation:^(id result)
     {
         @try
         {
             NSDictionary *temp =[result mutableCopy];
             msgArr = [temp valueForKey:@"data"];
             
             if (msgArr.count>0)
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

-(void)tableView:(UITableView *)tableView expandCell:(MessageCell *)cell withIndexPath:(NSIndexPath *)indexPath
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

-(void)tableView:(UITableView *)tableView collapseCell:(MessageCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
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
    
    
    return msgArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil];
    MessageCell *cell = [nib objectAtIndex:0];
    if (!isExpanded)
    {
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }
    else
    {
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
    }
    NSDictionary *msg = [msgArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[msg valueForKey:@"MessageTitle"]];
    cell.lblDesc.text=[NSString stringWithFormat:@"%@",[msg valueForKey:@"Discription"]];

    /*cell.backgroundColor = [UIColor clearColor];
     NSMutableDictionary *dic = (NSMutableDictionary*)[self.otherPgmArr objectAtIndex:indexPath.row];
     cell.questionView.backgroundColor = theme_color;
     if (!isExpanded)
     {
     NSString *date = [GeneralVC MMMM_dd_yyyy_dateConvertor:[dic valueForKey:@"progStartDate"]];
     date = [date stringByAppendingString:[NSString stringWithFormat:@"  %@",[GeneralVC convertTimeFromMileSecond:[dic valueForKey:@"progStartTime"]]]];
     cell.questionLbl.text = date;
     cell.txtanswer.attributedText = [GeneralVC htmltoStringConverter:[dic valueForKey:@"progDescription"]];
     [GeneralVC setupTextView:cell.txtanswer withDelegate:self];
     
     cell.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
     }
     else
     {
     NSString *date = [GeneralVC MMMM_dd_yyyy_dateConvertor:[dic valueForKey:@"progStartDate"]];
     date = [date stringByAppendingString:[NSString stringWithFormat:@"  %@",[GeneralVC convertTimeFromMileSecond:[dic valueForKey:@"progStartTime"]]]];
     cell.questionLbl.text = date;
     cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
     }
     
     cell.img.layer.borderColor = [UIColor whiteColor].CGColor;
     cell.img.layer.cornerRadius = cell.img.bounds.size.width/2;
     cell.img.layer.borderWidth = 2.0F;
     cell.img.clipsToBounds = true;
     cell.img.image = [UIImage imageNamed:@"Loading.png"];
     cell.img.hidden = YES;
     
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
     dispatch_async(queue, ^{
     int id = [[dic valueForKey:@"progId"]intValue];
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:MoreInfoImage,BaseUrl,id]];
     NSData *data = [NSData dataWithContentsOfURL:url];
     UIImage *img = [[UIImage alloc] initWithData:data];
     // [cell.img setShowActivityIndicatorView:YES];
     // [cell.img setIndicatorStyle:UIActivityIndicatorViewStyleGray];
     dispatch_async(dispatch_get_main_queue(), ^{
     [cell.img sd_setImageWithURL:url
     placeholderImage:GifLoading
     options:SDWebImageRefreshCached];
     });
     
     if (img) {
     cell.imgWidth.constant = 45;
     
     }
     else
     {
     cell.img.hidden = YES;
     
     cell.imgWidth.constant = 0;
     }
     });
     */
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
        return 80;
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

@end
