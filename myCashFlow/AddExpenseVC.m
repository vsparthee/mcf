//
//  AddExpenseVC.m
//  myCashflow
//
//  Created by Rishi on 10/5/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AddExpenseVC.h"

@interface AddExpenseVC ()

@end

@implementation AddExpenseVC

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
        //[self.parent home];
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

- (IBAction)action_Submit:(UIButton *)sender
{
    NSMutableDictionary *apiDic = [[NSMutableDictionary alloc]init];
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [apiDic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtDate.text] forKey:@"ExpenseDate"];
    [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtDesc.text] forKey:@"Description"];
    [apiDic setObject:[NSString stringWithFormat:@"%@",self.txtAmount.text] forKey:@"Amount"];

    APIHandler *api = [[APIHandler alloc]init];
    [api api_MyBudgetDailyExpenseCreate:apiDic withSuccess:^(id result)
    {
        [General makeToast:@"Your expense added successfully" withToastView:self.view];
        int64_t delayInSeconds = 2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                       {
                           if( [self navigationController])
                           {
                               [self.navigationController popViewControllerAnimated:YES];
                           }
                           else
                           {
                               [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
                           }

                       });
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
    
    }];
    

}

- (IBAction)action_Cancel:(UIButton *)sender
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
@end
