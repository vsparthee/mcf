//
//  ExpenseCell.h
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;

@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@end
