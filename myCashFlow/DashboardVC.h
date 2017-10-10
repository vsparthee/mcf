//
//  DashboardVC.h
//  myCashflow
//
//  Created by Rishi on 9/24/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardVC : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblProfileTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@property (weak, nonatomic) IBOutlet UILabel *lblAcc;
@property (weak, nonatomic) IBOutlet UILabel *lblnum;
@property (weak, nonatomic) IBOutlet UILabel *lbloffer;
@property (weak, nonatomic) IBOutlet UILabel *lblappoint;
@property (weak, nonatomic) IBOutlet UILabel *lblfinance;
@property (weak, nonatomic) IBOutlet UILabel *lbltax;





@end
