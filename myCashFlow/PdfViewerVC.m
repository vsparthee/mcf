//
//  PdfViewerVC.m
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "PdfViewerVC.h"

@interface PdfViewerVC ()
{
    NSData *fileData;
}
@end

@implementation PdfViewerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStr]];
    fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://che.org.il/wp-content/uploads/2016/12/pdf-sample.pdf"]];

    
    [self.webView loadData:fileData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
