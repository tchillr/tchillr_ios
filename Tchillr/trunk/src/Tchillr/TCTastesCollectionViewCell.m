//
//  TCTastesCollectionViewCell.m
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTastesCollectionViewCell.h"

// Categories
#import "UIColor+Tchillr.h"

@interface TCTastesCollectionViewCell ()

#pragma mark Setup
- (void)setup;

@end

@implementation TCTastesCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}
- (void)awakeFromNib {
	[super awakeFromNib];
	[self setup];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.titleLabel.transform = CGAffineTransformMakeRotation(- M_PI_2);
	self.titleLabel.frame = CGRectMake(self.bounds.size.width - self.titleLabel.frame.size.width - 10.0,
									   self.bounds.size.height - self.titleLabel.frame.size.height - 50.0,
									   self.titleLabel.frame.size.width,
									   self.titleLabel.frame.size.height);
}

#pragma mark Setup
- (void)setup {
	[self.titleLabel setTextColor:[UIColor tcWhite]];
	[self.titleLabel setHighlightedTextColor:[UIColor tcBlack]];
}

@end
