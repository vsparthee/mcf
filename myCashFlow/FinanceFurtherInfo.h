//
//  FinanceFurtherInfo.h
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanceFurtherInfo : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblProfileTitle;
@property (strong,nonatomic) NSMutableDictionary *selectedFinance;
@property (weak, nonatomic) IBOutlet UITableView *tblFurtherInfo;

@end
