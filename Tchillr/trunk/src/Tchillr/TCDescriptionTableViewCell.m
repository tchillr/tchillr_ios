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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize idealSize = [self idealSizeForCell];
    self.descriptionLabel.frame = CGRectMake(self.descriptionLabel.frame.origin.x, self.descriptionLabel.frame.origin.y, idealSize.width, idealSize.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, idealSize.height);
}

#pragma mark Ideal Size For Cell
- (CGSize) idealSizeForCell {
    CGSize idealSize = [self.descriptionLabel idealSize];                        
    idealSize.height += kActivityDetailSeparatorHeight + self.descriptionLabel.frame.origin.x * 2;
    return idealSize;
}

@end
