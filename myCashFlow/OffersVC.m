//
//  OffersVC.m
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "OffersVC.h"
#import "OffersCell.h"
@interface OffersVC ()
{
    NSMutableArray *offerArr;
    UILabel *nodata;
    int height;

}
@end

@implementation OffersVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Discount"];

    self.tblOfferList.separatorStyle = UITableViewCellSeparatorStyleNone;

    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        height=[UIScreen mainScreen].bounds.size.width/2.2;
    }
    else
    {
        height=[UIScreen mainScreen].bounds.size.height/2;
    }
    
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
    [api api_Discount:^(id result)
     {
         @try
         {
             NSDictionary *temp =[result mutableCopy];
             offerArr = [temp valueForKey:@"data"];
             if (offerArr.count>0)
             {
                 [nodata removeFromSuperview];
             }
             else
             {
                 [self.tblOfferList addSubview:nodata];
             }
             [self.tblOfferList reloadData];
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
    return offerArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OffersCell" owner:self options:nil];
    OffersCell *cell = [nib objectAtIndex:0];
    NSDictionary *video = [offerArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[video valueForKey:@"Title"]];
    cell.lblDate.text=[NSString stringWithFormat:@"%@",[video valueForKey:@"UpdateDate"]];

    NSString *strURL = [NSString stringWithFormat:@"%@",[video valueForKey:@"ImageURL"]];
    NSURL *url = [NSURL URLWithString:strURL];
    [cell.imgOffer setShowActivityIndicatorView:YES];
    [cell.imgOffer setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.imgOffer sd_setImageWithURL:url
                     placeholderImage:nil
                              options:SDWebImageRefreshCached];
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];
    cell.imgOffer.tag=indexPath.row+100;
    cell.imgOffer.userInteractionEnabled = YES;
    
    [cell.imgOffer addGestureRecognizer:tapped];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return height;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        height=[UIScreen mainScreen].bounds.size.height/2.2;
        [self.tblOfferList reloadData];
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        height=[UIScreen mainScreen].bounds.size.width/2;
        [self.tblOfferList reloadData];
    }
}

- (void)bigButtonTapped:(UITapGestureRecognizer *)sender
{
    
    UIImageView *myImageView = (UIImageView *)[self.tblOfferList viewWithTag:sender.view.tag];
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    
    imageInfo.image = myImageView.image;
    imageInfo.referenceRect = myImageView.frame;
    imageInfo.referenceView = myImageView.superview;
    imageInfo.referenceContentMode = myImageView.contentMode;
    imageInfo.referenceCornerRadius = myImageView.layer.cornerRadius;
    
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
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
