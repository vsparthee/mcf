//
//  ViewHealthInsVC.m
//  myCashflow
//
//  Created by Rishi on 9/26/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ViewHealthInsVC.h"

@interface ViewHealthInsVC (){
    float height;
}
@end

@implementation ViewHealthInsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"View Report"];
    self.lblpolicynum.text=[TSLanguageManager localizedString:@"Policy No"];
    self.lbldoc.text=[TSLanguageManager localizedString:@"Document"];
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

    NSString *strURL = [NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"HealthDocument1URL"]];
    NSURL *url = [NSURL URLWithString:strURL];
    [self.imgDoc1 setShowActivityIndicatorView:YES];
    [self.imgDoc1 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc1 sd_setImageWithURL:url
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgDoc1.tag=100;
    self.imgDoc1.userInteractionEnabled = YES;
    
    [self.imgDoc1 addGestureRecognizer:tapped1];

    NSString *strURL1 = [NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"HealthDocument2URL"]];
    NSURL *url1 = [NSURL URLWithString:strURL1];
    [self.imgDoc2 setShowActivityIndicatorView:YES];
    [self.imgDoc2 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc2 sd_setImageWithURL:url1
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgDoc2.tag=101;
    self.imgDoc2.userInteractionEnabled = YES;
    
    [self.imgDoc2 addGestureRecognizer:tapped2];

    self.lblComment.text=[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"Comments"]];
    self.lblComment.editable = FALSE;
    self.lblComment.selectable = FALSE;
    self.lblComment.scrollEnabled =TRUE;
    self.lblComment.textAlignment = NSTextAlignmentNatural;
    self.lblComment.textColor = [UIColor grayColor];
    self.lblComment.backgroundColor = [UIColor clearColor];
    self.lblComment.userInteractionEnabled = TRUE;

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)bigButtonTapped:(UITapGestureRecognizer *)sender
{
    
    
    UIImageView *temp = [[UIImageView alloc]init];
    if (sender.view.tag == 100)
    {
        temp=self.imgDoc1;
    }
    else
    {
        temp=self.imgDoc2;
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


@end
