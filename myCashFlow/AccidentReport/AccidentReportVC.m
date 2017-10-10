//
//  AccidentReportVC.m
//  myCashflow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AccidentReportVC.h"
#import "InsuranceReportVC.h"
@interface AccidentReportVC ()
{
    int type;
}
@end

@implementation AccidentReportVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Accident Reporting"];
    self.lblcar.text=[TSLanguageManager localizedString:@"Report Car Accident"];
    self.lblhealth.text=[TSLanguageManager localizedString:@"Report Health Insurance"];
    self.lblhome.text=[TSLanguageManager localizedString:@"Report Home Insurance"];

    self.imgcar.layer.cornerRadius=self.imgcar.bounds.size.height/2;
    self.imgcar.clipsToBounds=YES;
    self.imghealth.layer.cornerRadius=self.imgcar.bounds.size.height/2;
    self.imghealth.clipsToBounds=YES;
    self.imghome.layer.cornerRadius=self.imgcar.bounds.size.height/2;
    self.imghome.clipsToBounds=YES;
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
- (IBAction)menuAction:(id)sender
{
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}
- (IBAction)backAction:(id)sender
{
    if( [self navigationController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];*/
        [self.parent home];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"accident_to_insurance"])
    {
        InsuranceReportVC *vc = [segue destinationViewController];
        vc.type = type;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)action_Insurance:(UIButton *)sender
{
    if (sender.tag==100)
    {
        type=1;
    }
    if (sender.tag==200)
    {
        type=2;
    }
    if (sender.tag==300)
    {
        type=3;
    }
    [self performSegueWithIdentifier:@"accident_to_insurance" sender:self];
}
@end
