//
//  UserProfileVC.m
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "UserProfileVC.h"

@interface UserProfileVC ()

@end

@implementation UserProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.settingView.hidden=YES;
    
    if( [self navigationController]||[self presentingViewController])
    {
        self.btnMenu.hidden=YES;
    }
    else
    {
        self.btnMenu.hidden=NO;
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
        [self.parent home];
    }
}


- (IBAction)action_EditImage:(UIButton *)sender {
}
- (IBAction)action_Male:(UIButton *)sender {
}

- (IBAction)action_Female:(UIButton *)sender {
}
- (IBAction)action_Setting:(UIButton *)sender
{
    if (self.settingView.hidden)
    {
        self.settingView.hidden=NO;
    }
    else
    {
        self.settingView.hidden=YES;

    }
}
- (IBAction)action_ChangePwd:(UIButton *)sender {
}

- (IBAction)action_ChangePin:(UIButton *)sender {
}

- (IBAction)action_ChangeLang:(UIButton *)sender {
}

- (IBAction)action_SignOut:(UIButton *)sender {
}
@end
