//
//  NumbersVC.h
//  myCashflow
//
//  Created by Rishi on 9/26/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
@interface NumbersVC : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *tblnumber;
@property (weak, nonatomic) LeftMenuVC *parent;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end
