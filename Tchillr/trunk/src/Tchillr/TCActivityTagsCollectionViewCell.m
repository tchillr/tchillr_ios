//
//  TCActivityTagsCollectionView.m
//  Tchillr
//
//  Created by Jad on 28/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivityTagsCollectionViewCell.h"

// Images
#define kHeartImage [UIImage imageNamed:@"btn_heart_empty"]
#define kHeartSelectedImage [UIImage imageNamed:@"btn_heart_selected"]
#define kHeartHightlightedImage [UIImage imageNamed:@"btn_heart_highlighted"]

@implementation TCActivityTagsCollectionViewCell

- (void)setUserInterest:(BOOL)userInterest {
    if (userInterest != _userInterest) {
        _userInterest = userInterest;
        self.tagSelectionImageView.image = (_userInterest) ? kHeartHightlightedImage : kHeartImage;
    }
}

@end
