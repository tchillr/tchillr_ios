//
//  TCDescriptionTableViewCell.m
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCDescriptionTableViewCell.h"
#import "TCActivityDetailResizableCell.h"
#import "UILabel+Tchillr.h"

@implementation TCDescriptionTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize idealSize = [self idealSizeForCell];
    if (idealSize.height > 0) {
        self.descriptionLabel.frame = CGRectMake(self.descriptionLabel.frame.origin.x, self.descriptionLabel.frame.origin.y, idealSize.width, idealSize.height);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, idealSize.height);
    }
    else {
        self.descriptionLabel.frame = CGRectZero;
        self.frame = CGRectZero;
    }
}

#pragma mark Ideal Size For Cell
- (CGSize) idealSizeForCell {
    CGSize idealSize = [self.descriptionLabel idealSize];
    if (idealSize.height > 0) {
        idealSize.height += kActivityDetailSeparatorHeight + self.descriptionLabel.frame.origin.x * 2;
    }
    return idealSize;
}

@end
