//
//  MessageVC.h
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
#import "HVTableView.h"
@interface MessageVC : UIViewController
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet HVTableView *tblTax;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end
