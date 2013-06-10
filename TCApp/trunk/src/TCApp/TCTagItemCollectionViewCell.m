//
//  TagItemCollectionViewCell.m
//  BMInterestsPicker
//
//  Created by Meski Badr on 09/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "TCTagItemCollectionViewCell.h"

@interface TCTagItemCollectionViewCell ()

@property (nonatomic, retain, readwrite) IBOutlet UILabel *titleLabel;

@end

@implementation TCTagItemCollectionViewCell

#pragma mark getters/setters
@synthesize title = _title;
- (void)setTitle:(NSString *)title {
    if(![_title isEqualToString:title]) {
        _title = [title uppercaseString];
        [self.titleLabel setText:_title];
        [self setNeedsLayout];
    }
}

@synthesize titleColor = _titleColor;
- (void)setTitleColor:(UIColor *)titleColor {
    if(![_titleColor isEqual:titleColor]) {
        _titleColor = titleColor;
        [self.titleLabel setTextColor:_titleColor];
    }
}

#pragma mark - LifeCycle Methods
- (void)awakeFromNib {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontViewHasBeenTapped:)];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark - UIGestureRecognizer Methods
- (void)frontViewHasBeenTapped:(UITapGestureRecognizer *)tapGesture {
    if([tapGesture state] == UIGestureRecognizerStateEnded) {
        if([self.delegate respondsToSelector:@selector(tagItemCollectionViewCellHasBeenTapped:)]) {
            [self.delegate tagItemCollectionViewCellHasBeenTapped:self];
        }
    }
}

@end
