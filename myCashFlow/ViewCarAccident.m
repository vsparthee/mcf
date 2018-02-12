//
//  ViewCarAccident.m
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ViewCarAccident.h"
@interface ViewCarAccident ()
{
    float height;
}
@end

@implementation ViewCarAccident

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"View Report"];
    self.lblpolicynum.text=[TSLanguageManager localizedString:@"Policy No"];
    self.lblcardoc.text=[TSLanguageManager localizedString:@"Car Document"];
    self.lblfront.text=[TSLanguageManager localizedString:@"Front Side"];
    self.lblback.text=[TSLanguageManager localizedString:@"Back Side"];
    self.lblright.text=[TSLanguageManager localizedString:@"Right Side"];
    self.lblleg.text=[TSLanguageManager localizedString:@"Left Side"];
    self.lblcmt.text=[TSLanguageManager localizedString:@"Comments"];

    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        height=[UIScreen mainScreen].bounds.size.width;
    }
    else
    {
        height=[UIScreen mainScreen].bounds.size.height;
    }
    self.viewHeight.constant=height-64;
    
    self.lblPolicyNum.text=[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"PolicyNo"]];
    self.lblDate.text=[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"ReportedDate"]];
    
    UITapGestureRecognizer *tapped1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];
    
    UITapGestureRecognizer *tapped2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];

    UITapGestureRecognizer *tapped3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];

    UITapGestureRecognizer *tapped4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];

    UITapGestureRecognizer *tapped5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];

    UITapGestureRecognizer *tapped6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];

    NSURL *insurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"CarInsurancedocUrl"]]];
    [self.imgDoc1 setShowActivityIndicatorView:YES];
    [self.imgDoc1 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc1 sd_setImageWithURL:insurl
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgDoc1.tag=100;
    self.imgDoc1.userInteractionEnabled = YES;

    [self.imgDoc1 addGestureRecognizer:tapped1];

    
    NSURL *rcurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"CarRCdocNameURL"]]];
    [self.imgDoc2 setShowActivityIndicatorView:YES];
    [self.imgDoc2 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc2 sd_setImageWithURL:rcurl
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgDoc2.tag=101;
    self.imgDoc2.userInteractionEnabled = YES;

    [self.imgDoc2 addGestureRecognizer:tapped2];

    
    NSURL *righturl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"RightImageURL"]]];
    [self.imgRight setShowActivityIndicatorView:YES];
    [self.imgRight setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgRight sd_setImageWithURL:righturl
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgRight.tag=102;
    self.imgRight.userInteractionEnabled = YES;

    [self.imgRight addGestureRecognizer:tapped3];

    NSURL *lefturl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"LeftImageURL"]]];
    [self.imgLeft setShowActivityIndicatorView:YES];
    [self.imgLeft setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgLeft sd_setImageWithURL:lefturl
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgLeft.tag=103;
    self.imgLeft.userInteractionEnabled = YES;

    [self.imgLeft addGestureRecognizer:tapped4];

    
    NSURL *fronturl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"FrontImageURL"]]];
    [self.imgFront setShowActivityIndicatorView:YES];
    [self.imgFront setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgFront sd_setImageWithURL:fronturl
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgFront.tag=104;
    self.imgFront.userInteractionEnabled = YES;

    [self.imgFront addGestureRecognizer:tapped5];

    
    NSURL *backurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"BackImageURL"]]];
    [self.imgBack setShowActivityIndicatorView:YES];
    [self.imgBack setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgBack sd_setImageWithURL:backurl
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgBack.tag=105;
    self.imgBack.userInteractionEnabled = YES;

    [self.imgBack addGestureRecognizer:tapped6];
    
    self.lblComment.text=[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"Comments"]];
    self.lblComment.editable = FALSE;
    self.lblComment.selectable = FALSE;
    self.lblComment.scrollEnabled =TRUE;
    self.lblComment.textAlignment = NSTextAlignmentNatural;
    self.lblComment.textColor = [UIColor grayColor];
    self.lblComment.backgroundColor = [UIColor clearColor];
    self.lblComment.userInteractionEnabled = TRUE;

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.viewHeight.constant=height;
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.viewHeight.constant=height-64;
        
    }
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
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)bigButtonTapped:(UITapGestureRecognizer *)sender
{
    
    
    UIImageView *temp = [[UIImageView alloc]init];
    if (sender.view.tag == 100)
    {
        temp=self.imgDoc1;
    }
    else if (sender.view.tag == 101)
    {
        temp=self.imgDoc2;
    }
    else if (sender.view.tag == 102)
    {
        temp=self.imgRight;
    }
    else if (sender.view.tag == 103)
    {
        temp=self.imgLeft;
    }
    else if (sender.view.tag == 104)
    {
        temp=self.imgFront;
    }
    else
    {
        temp=self.imgBack;
    }
    
    
    
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];

    imageInfo.image = temp.image;
    imageInfo.referenceRect = temp.frame;
    imageInfo.referenceView = temp.superview;
    imageInfo.referenceContentMode = temp.contentMode;
    imageInfo.referenceCornerRadius = temp.layer.cornerRadius;
    
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
