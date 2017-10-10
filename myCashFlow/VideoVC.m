//
//  VideoVC.m
//  myCashflow
//
//  Created by Rishi on 9/29/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "VideoVC.h"
#import "VideosCell.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "MPMoviePlayerController+BackgroundPlayback.h"

@interface VideoVC ()
{
    NSMutableArray *videoArr;
    UILabel *nodata;
    int height;
}
@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Videos"];

    self.tblVideo.separatorStyle = UITableViewCellSeparatorStyleNone;

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
    [api api_VideosList:^(id result)
     {
         NSDictionary *temp =[result mutableCopy];
         videoArr = [temp valueForKey:@"data"];
         
         if (videoArr.count>0)
         {
             [nodata removeFromSuperview];
         }
         else
         {
             [self.tblVideo addSubview:nodata];
         }
         [General stopLoader];
         [self.tblVideo reloadData];

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
    return videoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VideosCell" owner:self options:nil];
    VideosCell *cell = [nib objectAtIndex:0];

    NSDictionary *video = [videoArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[video valueForKey:@"VideoTitle"]];
    NSString *strURL = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",[General extractYoutubeIdFromLink:[NSString stringWithFormat:@"%@",[video valueForKey:@"URL"]]]];
    NSURL *url = [NSURL URLWithString:strURL];
    [cell.imgVideo setShowActivityIndicatorView:YES];
    [cell.imgVideo setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.imgVideo sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [cell.videologo setHidden:NO];
    }];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *video = [videoArr objectAtIndex:indexPath.row];
    
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:[General extractYoutubeIdFromLink:[NSString stringWithFormat:@"%@",[video valueForKey:@"URL"]]]];
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
        [self.tblVideo reloadData];
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        height=[UIScreen mainScreen].bounds.size.width/3;
        [self.tblVideo reloadData];
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
