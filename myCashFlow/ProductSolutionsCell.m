//
//  ProductSolutionsCell.m
//  myCashflow
//
//  Created by Rishi on 9/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ProductSolutionsCell.h"

@implementation ProductSolutionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lblviewdoc.text=[TSLanguageManager localizedString:@"View Document"];    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
