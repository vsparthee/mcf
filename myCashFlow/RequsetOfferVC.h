//
//  RequsetOfferVC.h
//  myCashflow
//
//  Created by Rishi on 10/15/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"

@interface RequsetOfferVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *typelbl;
@property (weak, nonatomic) IBOutlet UITextField *txtPolicytype;
@property (weak, nonatomic) IBOutlet UITableView *tblOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)action_Submit:(UIButton *)sender;
- (IBAction)action_Cancel:(UIButton *)sender;
@property(nonatomic,strong) UIPickerView *picker;
@property(nonatomic,strong) NSMutableArray *pickerArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) LeftMenuVC *parent;

//@property(nonatomic,strong) UIPickerView *resultpicker;
//@property(nonatomic,strong) NSMutableArray *resultpickerArr;
@property (strong, nonatomic) IBOutlet UIView *policyView;
@property (strong, nonatomic) IBOutlet UIView *carInsuranceView;
@property (weak, nonatomic) IBOutlet UIView *uploadImageBaseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgbaseHeight;
- (IBAction)action_doc_Front:(UIButton *)sender;
- (IBAction)action_doc_Back:(UIButton *)sender;
- (IBAction)action_Licence_Front:(UIButton *)sender;
- (IBAction)action_Licence_Back:(UIButton *)sender;

- (IBAction)action_Policy_Doc:(UIButton *)sender;
- (IBAction)action_Car_Policy_Doc:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *docFront;
@property (weak, nonatomic) IBOutlet UIImageView *docBack;
@property (weak, nonatomic) IBOutlet UIImageView *licFront;
@property (weak, nonatomic) IBOutlet UIImageView *licBack;
@property (weak, nonatomic) IBOutlet UIImageView *policyDoc;
@property (weak, nonatomic) IBOutlet UIImageView *carPolicyDoc;


@end
