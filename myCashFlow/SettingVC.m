//
//  SettingVC.m
//  myCashFlow
//
//  Created by Rishi on 10/7/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "SettingVC.h"
#import "SettingsCell.h"
#import "VENTouchLock.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblSetting.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblSetting.allowsMultipleSelection = NO;
    //self.view.backgroundColor = theme_color;
    _titleArry = [NSArray arrayWithObjects:@"Change PIN", @"Change Password", @"Change Language", nil];
    _imageArry = [NSArray arrayWithObjects:@"passcode",@"PasswordLock", @"language", nil];
    [self.tblSetting reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isResetPwd"] boolValue]==YES)
    {
        VENTouchLockCreatePasscodeViewController *createPasscodeVC = [[VENTouchLockCreatePasscodeViewController alloc] init];
        [self presentViewController:[createPasscodeVC embeddedInNavigationController] animated:YES completion:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SettingsCell" owner:self options:nil];
    SettingsCell *cell = [nib objectAtIndex:0];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.menuTitle.text = [_titleArry objectAtIndex:indexPath.row];
    cell.menuImg.image = [UIImage imageNamed:[_imageArry objectAtIndex:indexPath.row]];
    cell.menuImg.tintColor = DARK_BG;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
            
        VENTouchLockEnterPasscodeViewController *showPasscodeVC = [[VENTouchLockEnterPasscodeViewController alloc] init];
        [self presentViewController:[showPasscodeVC embeddedInNavigationController] animated:YES completion:nil];
    }
    
    if(indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"setting_to_changepwd" sender:self];
    }
    
    if(indexPath.row == 2)
    {
      
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
