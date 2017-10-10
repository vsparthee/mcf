//
//  SettingVC.h
//  myCashFlow
//
//  Created by Rishi on 10/7/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface SettingVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblSetting;
@property (weak, nonatomic) IBOutlet UITableView *tblLang;
@property (weak, nonatomic) IBOutlet UIView *langView;

@property (strong, nonatomic) NSArray *titleArry;
@property (strong, nonatomic) NSArray *imageArry;
@property (weak, nonatomic) LeftMenuVC *parent;

@end
