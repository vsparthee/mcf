//
//  InsuranceReportCell.h
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceReportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnView;
@property (weak, nonatomic) IBOutlet UILabel *lblPolicyNum;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@property (weak, nonatomic) IBOutlet UILabel *policylbl;
@property (weak, nonatomic) IBOutlet UILabel *datelbl;


@end
