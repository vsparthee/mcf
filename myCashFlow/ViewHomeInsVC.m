//
//  ViewHomeInsVC.m
//  myCashflow
//
//  Created by Rishi on 9/26/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ViewHomeInsVC.h"

@interface ViewHomeInsVC ()
{
    float height;
}
@end

@implementation ViewHomeInsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"View Report"];
    self.lblpolicynum.text=[TSLanguageManager localizedString:@"Policy No"];
    self.lbldoc2.text=[TSLanguageManager localizedString:@"Document2"];
    self.lblimg1.text=[TSLanguageManager localizedString:@"Image1"];
    self.lblimg2.text=[TSLanguageManager localizedString:@"Image2"];
    self.lbldoc.text=[TSLanguageManager localizedString:@"Document1"];    self.lblPolicyNum.text=[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"PolicyNo"]];
    self.lblDate.text=[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"ReportedDate"]];
    self.lblcmt.text=[TSLanguageManager localizedString:@"Comments"];

    UITapGestureRecognizer *tapped1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];
    
    UITapGestureRecognizer *tapped2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];
    
    UITapGestureRecognizer *tapped3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];
    
    UITapGestureRecognizer *tapped4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)];
    

    NSString *strURL = [NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"HomeDocument1Url"]];
    NSURL *url = [NSURL URLWithString:strURL];
    [self.imgDoc1 setShowActivityIndicatorView:YES];
    [self.imgDoc1 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc1 sd_setImageWithURL:url
                placeholderImage:nil
                         options:SDWebImageRefreshCached];
    
    self.imgDoc1.tag=100;
    self.imgDoc1.userInteractionEnabled = YES;
    
    [self.imgDoc1 addGestureRecognizer:tapped1];

    
    NSString *strURL1 = [NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"HomeDocument2URL"]];
    NSURL *url1 = [NSURL URLWithString:strURL1];
    [self.imgDoc2 setShowActivityIndicatorView:YES];
    [self.imgDoc2 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc2 sd_setImageWithURL:url1
                placeholderImage:nil
                         options:SDWebImageRefreshCached];
    
    self.imgDoc2.tag=101;
    self.imgDoc2.userInteractionEnabled = YES;
    
    [self.imgDoc2 addGestureRecognizer:tapped2];

    NSString *strURL2 = [NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"ImageDoc1"]];
    NSURL *url2 = [NSURL URLWithString:strURL2];
    [self.imgDoc3 setShowActivityIndicatorView:YES];
    [self.imgDoc3 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc3 sd_setImageWithURL:url2
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgDoc3.tag=102;
    self.imgDoc3.userInteractionEnabled = YES;
    
    [self.imgDoc3 addGestureRecognizer:tapped3];

    NSString *strURL3 = [NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"ImageDoc2"]];
    NSURL *url3 = [NSURL URLWithString:strURL3];
    [self.imgDoc4 setShowActivityIndicatorView:YES];
    [self.imgDoc4 setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imgDoc4 sd_setImageWithURL:url3
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    self.imgDoc4.tag=103;
    self.imgDoc4.userInteractionEnabled = YES;
    
    [self.imgDoc4 addGestureRecognizer:tapped4];

    self.lblComment.text=[NSString stringWithFormat:@"%@",[self.selectedDic valueForKey:@"Comments"]];
    self.lblComment.editable = FALSE;
    self.lblComment.selectable = FALSE;
    self.lblComment.scrollEnabled =TRUE;
    self.lblComment.textAlignment = NSTextAlignmentNatural;
    self.lblComment.textColor = [UIColor grayColor];
    self.lblComment.backgroundColor = [UIColor clearColor];
    self.lblComment.userInteractionEnabled = TRUE;
    
    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        height=[UIScreen mainScreen].bounds.size.width;
    }
    else
    {
        height=[UIScreen mainScreen].bounds.size.height;
    }
    self.viewHeight.constant=height-64;
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
    else if (sender.view.tag == 101)
    {
        temp=self.imgDoc2;
    }
    else if (sender.view.tag == 102)
    {
        temp=self.imgDoc3;
    }
    else
    {
        temp=self.imgDoc4;
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
