//
//  DocumentList.h
//  myCashFlow
//
//  Created by Rishi on 10/7/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"

@interface DocumentList : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblDocList;
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end
