//
//  ProductSolutionsCell.h
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSolutionsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *videologo;
@property (weak, nonatomic) IBOutlet UIButton *btnDocument;
@property (weak, nonatomic) IBOutlet UIButton *btnVideo;
@property (weak, nonatomic) IBOutlet UIView *pdfView;
@property (weak, nonatomic) IBOutlet UILabel *lblviewdoc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img1Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img2Width;
@property (weak, nonatomic) IBOutlet UIView *imgView;

@end
