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

@end

@implementation NumberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 6;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NumberListCell" owner:self options:nil];
    NumberListCell *cell = [nib objectAtIndex:0];
   // cell.btnView.layer.cornerRadius=cell.btnView.bounds.size.height/2;
    //cell.btnView.clipsToBounds=YES;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
