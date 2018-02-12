//
//  BudgetSettingCell.h
//  myCashflow
//
//  Created by Parthiban on 27/11/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BudgetSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleClone;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end
