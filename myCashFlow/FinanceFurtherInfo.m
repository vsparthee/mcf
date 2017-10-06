//
//  FinanceFurtherInfo.m
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "FinanceFurtherInfo.h"
#import "FurterInfoCell.h"
@interface FinanceFurtherInfo ()
{
    NSArray *otherFieldArr;
    UILabel *nodata;

}
@end

@implementation FinanceFurtherInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblFurtherInfo.separatorStyle = UITableViewCellSeparatorStyleNone;

    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = @"No data founds in product solution";
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;

    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    self.lblProfileTitle.text = [NSString stringWithFormat:@"%@ %@",[userInfo valueForKey:@"Firstname"],[userInfo valueForKey:@"Lastname"]];

    
    otherFieldArr = [self.selectedFinance valueForKey:@"OtherFields"];
    if (otherFieldArr.count>0)
    {
        [nodata removeFromSuperview];

    }
    else
    {
        [self.tblFurtherInfo addSubview:nodata];
    }
    [self.tblFurtherInfo reloadData];
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
{   return otherFieldArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FurterInfoCell" owner:self options:nil];
    FurterInfoCell *cell = [nib objectAtIndex:0];
    NSDictionary *finance = [otherFieldArr objectAtIndex:indexPath.row];
        
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Name"]];
    cell.lblDesc.text=[NSString stringWithFormat:@"%@",[finance valueForKey:@"Value"]];
    if (indexPath.row%2==0)
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70;
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
