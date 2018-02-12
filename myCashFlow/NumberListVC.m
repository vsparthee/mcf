//
//  NumberListVC.m
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "NumberListVC.h"
#import "NumberListCell.h"
@interface NumberListVC ()
{
    NSArray *contact;
}
@end

@implementation NumberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Numbers"];
    self.lbltitle.textAlignment=NSTextAlignmentCenter;
    contact=[self.selectedDic valueForKey:@"Contacts"];
    [self.tblNumberList reloadData];
    self.tblNumberList.estimatedRowHeight = 200;
    self.tblNumberList.rowHeight = 200;
    self.tblNumberList.rowHeight = UITableViewAutomaticDimension;
    self.tblNumberList.separatorStyle = UITableViewCellSeparatorStyleNone;

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
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contact.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NumberListCell" owner:self options:nil];
    NumberListCell *cell = [nib objectAtIndex:0];
    NSDictionary *dic=[contact objectAtIndex:indexPath.row];
    cell.lblNumber.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"PhoneNo"]];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"Name"]];
    [cell.btnCall addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnCall.tag=indexPath.row;

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewAutomaticDimension;
}

-(IBAction)callAction:(UIButton*)sender
{
    NSDictionary *dic = [contact objectAtIndex:sender.tag];
    NSString *tempPhoneNumber = [NSString stringWithFormat:@"%@",[dic valueForKey:@"PhoneNo"]];

   tempPhoneNumber= [tempPhoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:[NSString stringWithFormat:@"%@",tempPhoneNumber]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
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
