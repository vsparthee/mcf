//
//  ProductSolutionsVC.h
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface ProductSolutionsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblProduct;
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end
