//
//  PdfViewerVC.m
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "PdfViewerVC.h"
@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@interface PdfViewerVC ()<UIWebViewDelegate>
{
    NSData *fileData;
}
@end

@implementation PdfViewerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [General startLoader:self.view];

    if (_titleStr.length>1)
    {
        self.lblTitle.text=self.titleStr;
    }
    else
    {
        self.lblTitle.text=@"PDF Viewer";

    }
    self.webView.delegate=self;
   /*
    fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStr]];
   // fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://che.org.il/wp-content/uploads/2016/12/pdf-sample.pdf"]];

    
    [self.webView loadData:fileData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    self.webView.scalesPageToFit = YES;
    self.webView.backgroundColor = [UIColor whiteColor];*/
    
    NSURL *targetURL = [NSURL URLWithString:self.urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[targetURL host]];
    
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit = YES;
    self.webView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)action_Back:(UIButton *)sender
{
    if( [self navigationController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [General stopLoader];
}
- (IBAction)share:(UIButton*)sender
{
    NSArray *activityItems = [[NSArray alloc]initWithObjects:self.urlStr, nil];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = @[];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityViewControntroller.popoverPresentationController.sourceView = self.view;
        activityViewControntroller.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
    }
    [self presentViewController:activityViewControntroller animated:true completion:nil];
}
@end
