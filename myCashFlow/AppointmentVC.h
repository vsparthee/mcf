//
//  AppointmentVC.h
//  myCashflow
//
//  Created by Rishi on 9/27/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface AppointmentVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblAppointment;
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end
