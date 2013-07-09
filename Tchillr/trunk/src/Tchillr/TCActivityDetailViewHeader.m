//
//  TCActivityDetailViewHeader.m
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivityDetailViewHeader.h"
#import "UILabel+Tchillr.h"

#define kLabelSpacing 8

@implementation TCActivityDetailViewHeader


- (CGSize)layoutHeader {
    // Name label framing
    CGSize nameLabelIdealSize = [self.nameLabel idealSize];
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, nameLabelIdealSize.width, nameLabelIdealSize.height);
    // Day Label framing
    self.dayLabel.frame = CGRectMake(self.dayLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame) + kLabelSpacing, self.dayLabel.frame.size.width, self.dayLabel.frame.size.height);
    // Time Label framing
    self.timeLabel.frame = CGRectMake(self.timeLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame) + kLabelSpacing, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    // Short Description label framing
    CGSize shortDescriptionLabelIdealSize = [self.shortDescriptionLabel idealSize];
    self.shortDescriptionLabel.frame = CGRectMake(self.shortDescriptionLabel.frame.origin.x, CGRectGetMaxY(self.dayLabel.frame) + kLabelSpacing, self.shortDescriptionLabel.frame.size.width, shortDescriptionLabelIdealSize.height);
    // Fee label framing
    CGSize feeLabelIdealSize = [self.feeLabel idealSize];
    self.feeLabel.frame = CGRectMake(self.feeLabel.frame.origin.x, CGRectGetMaxY(self.shortDescriptionLabel.frame) + kLabelSpacing, self.feeLabel.frame.size.width, feeLabelIdealSize.height);
    // Header view framing
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.feeLabel.frame));
    return self.frame.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutHeader];
}

- (CGSize) idealSize {
    return [self layoutHeader];
}

@end
