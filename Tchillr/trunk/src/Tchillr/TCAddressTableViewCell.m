//
//  TCAddressTableViewCell.m
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCAddressTableViewCell.h"
#import "UILabel+Tchillr.h"

@implementation TCAddressTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    // Place label sizing
    CGSize placeLabelIdealSize = [self.placeLabel idealSize];
    self.placeLabel.frame = CGRectMake(self.placeLabel.frame.origin.x, self.placeLabel.frame.origin.y, placeLabelIdealSize.width, placeLabelIdealSize.height);
    // Address label sizing
    CGSize addressLabelIdealSize = [self.addressLabel idealSize];
    self.addressLabel.frame = CGRectMake(self.addressLabel.frame.origin.x, placeLabelIdealSize.height, addressLabelIdealSize.width, addressLabelIdealSize.height);
    // Address Cell sizing
    CGSize idealSize = [self idealSizeForCell];    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, idealSize.height);
}

#pragma mark Ideal Size For Cell
- (CGSize) idealSizeForCell {
    return CGSizeMake(self.frame.size.width, [self.placeLabel idealSize].height + [self.addressLabel idealSize].height + kActivityDetailSeparatorHeight);
}



@end
