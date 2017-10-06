//
//  TaxFolderCell.h
//  myCashflow
//
//  Created by Rishi on 9/30/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaxFolderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *arrowBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblTaxYear;
@property (weak, nonatomic) IBOutlet UILabel *lblFilingDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIView *docDownloadView;
@property (weak, nonatomic) IBOutlet UIButton *btndownload;

@end
