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
#import "langCell.h"
@interface SettingVC ()
{
    NSMutableArray *langlist,*langCode,*langArr;
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;

}
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblSetting.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblLang.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tblSetting.allowsMultipleSelection = NO;
    //self.view.backgroundColor = theme_color;
    _titleArry = [NSArray arrayWithObjects:@"Change PIN", @"Change Password", @"Change Language", nil];
    _imageArry = [NSArray arrayWithObjects:@"passcode",@"PasswordLock", @"language", nil];
    [self.tblSetting reloadData];
    
    langlist = [[NSMutableArray alloc]initWithObjects:@"English",@"German", nil];
    langCode = [[NSMutableArray alloc]initWithObjects:kLMDefaultLanguage,kLMGerman, nil];
    
    langArr = [[NSMutableArray alloc]init];
    for (int i =0; i<langlist.count; i++)
    {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        [temp setObject:[langlist objectAtIndex:i] forKey:@"language"];
        [temp setObject:[langCode objectAtIndex:i] forKey:@"language_code"];
        [langArr addObject:temp];
    }
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2)-75, ([UIScreen mainScreen].bounds.size.height/2)-75, 150, 150)];
    loadingView.backgroundColor = [UIColor colorWithRed:0.06 green:0.10 blue:0.15 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(50, 50, 50, 50);
    [loadingView addSubview:activityView];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 110, 118, 30)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = UITextAlignmentCenter;
    loadingLabel.text = @"Setup Language...";
    [loadingView addSubview:loadingLabel];
    [self.tblLang reloadData];

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==100)
    {
        return [_titleArry count];

    }
    else
    {
        return [langArr count];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==100)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SettingsCell" owner:self options:nil];
        SettingsCell *cell = [nib objectAtIndex:0];
        NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
        [userdefaults setBool:YES forKey:@"doResetPwd"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.menuTitle.text = [_titleArry objectAtIndex:indexPath.row];
        cell.menuImg.image = [UIImage imageNamed:[_imageArry objectAtIndex:indexPath.row]];
        cell.menuImg.tintColor = DARK_BG;
        
        return cell;
    }
    else
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"langCell" owner:self options:nil];
        langCell *cell = [nib objectAtIndex:0];
        NSDictionary *temp = [langArr objectAtIndex:indexPath.row];
        cell.lbl.text = [temp valueForKey:@"language"];
        if ([[temp valueForKey:@"language_code"] isEqualToString:[[NSUserDefaults standardUserDefaults]valueForKey:@"kLMSelectedLanguageKey"]])
        {
            cell.backgroundColor = THEME_COLOR;
        }
        return cell;
    }

   

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100)
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
            self.langView.hidden=NO;

        }
        
    }
    else
    {
        NSDictionary *temp = [langArr objectAtIndex:indexPath.row];
        [self.view addSubview:loadingView];
        [TSLanguageManager setSelectedLanguage:[temp valueForKey:@"language_code"]];
        [activityView startAnimating];
        int64_t delayInSeconds = 5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                       {
                           [activityView stopAnimating];
                           [self.parent setupVC];
                           [self.parent home];
                       });
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
- (IBAction)acion_close:(id)sender
{
    self.langView.hidden=YES;
}

@end
