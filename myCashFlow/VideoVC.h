//
//  VideoVC.h
//  myCashflow
//
//  Created by Rishi on 9/29/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface VideoVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblVideo;
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end
