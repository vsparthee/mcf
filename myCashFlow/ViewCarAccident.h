//
//  ViewCarAccident.h
//  myCashflow
//
//  Created by Rishi on 9/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCarAccident : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
- (IBAction)action_Menu:(UIButton *)sender;
- (IBAction)action_Back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgDoc;
@property (weak, nonatomic) IBOutlet UIImageView *imgFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgRight;
@property (weak, nonatomic) IBOutlet UILabel *lblPolicyNum;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
