//
//  LeftMenuVC.m
//  CIC
//
//  Created by PPT-MAC-001 on 08/03/17.
//  Copyright © 2017 PPT-MAC-001. All rights reserved.
//

#import "LeftMenuVC.h"
#import "LeftMenuCell.h"
#import "AccidentReportVC.h"
#import "AppDelegate.h"
#import "NumbersVC.h"
#import "OffersVC.h"
#import "AppointmentVC.h"
#import "FinanceFolderVC.h"
#import "ConsultorProfileVC.h"
#import "ProductSolutionsVC.h"
#import "RecommandationVC.h"
#import "VideoVC.h"
#import "BudgetAndSaveRateVC.h"
#import "UserProfileVC.h"
#import "TaxFolderVC.h"
#import "MessageVC.h"
@interface LeftMenuVC ()
{
    NSString *newsID;
    AccidentReportVC *accreport;
    NumbersVC *number;
    OffersVC *offer;
    AppointmentVC *appoinment;
    FinanceFolderVC *finance;
    ConsultorProfileVC *consultor;
    ProductSolutionsVC *product;
    RecommandationVC *recommandation;
    VideoVC *video;
    BudgetAndSaveRateVC *budget;
    UserProfileVC *profile;
    TaxFolderVC *tax;
    MessageVC *msg;
}
@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVC];
}


-(void)setupVC
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelection = NO;
    //self.view.backgroundColor = theme_color;
    _titleArry = [NSArray arrayWithObjects:@"Home", @"Finance Folder", @"Taxes Folder", @"Budget & Save-Rate", @"Message Notification", @"Consultur Profile", @"Recommandation",@"Contracts Appointments",@"Videos",@"Accident Reporting",@"Numbers",@"Product Solutions",@"Discounts",@"My Accounts", nil];
    _imageArry = [NSArray arrayWithObjects:@"Home",@"Finance", @"Tax", @"Budget",@"Message", @"User", @"Recommandation",@"Contracts", @"Videos", @"heart",@"User", @"User", @"Recommandation",@"User",  nil];
    [self.tableView reloadData];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    static NSString *simpleTableIdentifier = @"cell";
    LeftMenuCell *cell = (LeftMenuCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil)
    {
        cell = [[LeftMenuCell alloc]init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.menuTitle.text = [_titleArry objectAtIndex:indexPath.row];
    cell.menuImg.image = [UIImage imageNamed:[_imageArry objectAtIndex:indexPath.row]];
    cell.menuImg.tintColor = BG_COLOR;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if(indexPath.row == 0)
    {
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 1)
    {
        finance = [storyboard instantiateViewControllerWithIdentifier:@"FinanceFolderVC"];
        finance.parent=self;
        [self.sideMenuController setRootViewController:finance];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 2)
    {
        tax = [storyboard instantiateViewControllerWithIdentifier:@"TaxFolderVC"];
        tax.parent=self;
        [self.sideMenuController setRootViewController:tax];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    if(indexPath.row == 3)
    {
        budget = [storyboard instantiateViewControllerWithIdentifier:@"BudgetAndSaveRateVC"];
        budget.parent=self;
        [self.sideMenuController setRootViewController:budget];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 4)
    {
        msg = [storyboard instantiateViewControllerWithIdentifier:@"MessageVC"];
        msg.parent=self;
        [self.sideMenuController setRootViewController:msg];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 5)
    {
        consultor = [storyboard instantiateViewControllerWithIdentifier:@"ConsultorProfileVC"];
        consultor.parent=self;
        [self.sideMenuController setRootViewController:consultor];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 6)
    {
        recommandation = [storyboard instantiateViewControllerWithIdentifier:@"RecommandationVC"];
        recommandation.parent=self;
        [self.sideMenuController setRootViewController:recommandation];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    if(indexPath.row == 7)
    {
        appoinment = [storyboard instantiateViewControllerWithIdentifier:@"AppointmentVC"];
        appoinment.parent=self;
        [self.sideMenuController setRootViewController:appoinment];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 8)
    {
        video = [storyboard instantiateViewControllerWithIdentifier:@"VideoVC"];
        video.parent=self;
        [self.sideMenuController setRootViewController:video];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 9)
    {
        accreport = [storyboard instantiateViewControllerWithIdentifier:@"AccidentReportVC"];
        accreport.parent=self;
        [self.sideMenuController setRootViewController:accreport];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 10)
    {
        number = [storyboard instantiateViewControllerWithIdentifier:@"NumbersVC"];
        number.parent=self;
        [self.sideMenuController setRootViewController:number];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 11)
    {
        product = [storyboard instantiateViewControllerWithIdentifier:@"ProductSolutionsVC"];
        product.parent=self;
        [self.sideMenuController setRootViewController:product];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }

    
    if(indexPath.row == 12)
    {
        offer = [storyboard instantiateViewControllerWithIdentifier:@"OffersVC"];
        offer.parent=self;
        [self.sideMenuController setRootViewController:offer];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 13)
    {
        profile = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
        profile.parent=self;
        [self.sideMenuController setRootViewController:profile];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }

}
-(void)home
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}
- (IBAction)homeAction:(id)sender {
    
  
    [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    
   /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Login"])
    {
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"WalkthroughNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];

    }
    else{
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashBoardNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    */
}


@end
