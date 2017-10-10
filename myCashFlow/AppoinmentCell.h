//
//  AppoinmentCell.h
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppoinmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblPolicyNum;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UIButton *btnBookAppointment;
@property (weak, nonatomic) IBOutlet UILabel *lblPremium;

@property (weak, nonatomic) IBOutlet UILabel *policylbl;
@property (weak, nonatomic) IBOutlet UILabel *premiumlbl;


@end
