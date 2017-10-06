//
//  ProductSolutionsVC.m
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ProductSolutionsVC.h"
#import "ProductSolutionsCell.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "MPMoviePlayerController+BackgroundPlayback.h"
@interface ProductSolutionsVC ()
{
    NSMutableArray *productArr;
    UILabel *nodata;
    int height;

}
@end

@implementation ProductSolutionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        height=[UIScreen mainScreen].bounds.size.width/2.2;
    }
    else
    {
        height=[UIScreen mainScreen].bounds.size.height/3;
    }
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = @"No data founds in product solution";
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;
    
    [self setupAPI];

}

-(void)setupAPI
{
    [General startLoader:self.view];
    APIHandler *api = [[APIHandler alloc]init];
    [api api_ProductSolution:^(id result)
     {
         NSDictionary *temp =[result mutableCopy];
         productArr = [temp valueForKey:@"data"];
         if (productArr.count>0)
         {
             [nodata removeFromSuperview];
         }
         else
         {
             [self.tblProduct addSubview:nodata];
         }
         [self.tblProduct reloadData];
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
    return productArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductSolutionsCell" owner:self options:nil];
    ProductSolutionsCell *cell = [nib objectAtIndex:0];
    
    NSDictionary *product = [productArr objectAtIndex:indexPath.row];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[product valueForKey:@"ProductName"]];
    cell.lblDesc.text=[NSString stringWithFormat:@"%@",[product valueForKey:@"Description"]];
    cell.lblDate.text=[NSString stringWithFormat:@"%@",[product valueForKey:@"UpdateDate"]];

    NSString *strURL = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",[General extractYoutubeIdFromLink:[NSString stringWithFormat:@"%@",[product valueForKey:@"VideoURL"]]]];
    NSURL *url = [NSURL URLWithString:strURL];
    [cell.img2 setShowActivityIndicatorView:YES];
    [cell.img2 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //[cell.img2 sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
    [cell.img2 sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [cell.videologo setHidden:NO];
    }];
    
    NSString *strURL1 = [NSString stringWithFormat:@"%@",[product valueForKey:@"ProductPhoto"]];
    NSURL *url1 = [NSURL URLWithString:strURL1];
    [cell.img1 setShowActivityIndicatorView:YES];
    [cell.img1 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.img1 sd_setImageWithURL:url1
                     placeholderImage:nil
                              options:SDWebImageRefreshCached];
    
    
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *product = [productArr objectAtIndex:indexPath.row];

    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:[General extractYoutubeIdFromLink:[NSString stringWithFormat:@"%@",[product valueForKey:@"VideoURL"]]]];
    videoPlayerViewController.moviePlayer.backgroundPlaybackEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
    videoPlayerViewController.preferredVideoQualities =  @[@(XCDYouTubeVideoQualityMedium360)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

#pragma mark - Notifications

- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:notification.object];
    MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    if (finishReason == MPMovieFinishReasonPlaybackError)
    {
        NSString *title = NSLocalizedString(@"Video Playback Error", @"Full screen video error alert - title");
        NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
        NSString *message = [NSString stringWithFormat:@"%@\n%@ (%@)", error.localizedDescription, error.domain, @(error.code)];
        NSString *cancelButtonTitle = NSLocalizedString(@"OK", @"Full screen video error alert - cancel button");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        [alertView show];
    }
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
        [self.tblProduct reloadData];
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        height=[UIScreen mainScreen].bounds.size.width/3;
        [self.tblProduct reloadData];
    }
}
@end
