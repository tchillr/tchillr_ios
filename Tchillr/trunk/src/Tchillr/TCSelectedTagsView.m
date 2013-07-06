//
//  TCSelectedTagsView.m
//  Tchillr
//
//  Created by Meski Badr on 06/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCSelectedTagsView.h"

#define kSelectedHeartImageName @"btn_heart_selected"

@interface TCSelectedTagsView ()

@end

@implementation TCSelectedTagsView

#define kHeartsMargin 0
@synthesize numberOfSelectedTags = _numberOfSelectedTags;
- (void)setNumberOfSelectedTags:(NSInteger)numberOfSelectedTags {
    if(numberOfSelectedTags != _numberOfSelectedTags) {
        _numberOfSelectedTags = numberOfSelectedTags;
        for (UIView *heart in self.subviews) {
            [heart removeFromSuperview];
        }
        for (int i=0; i<self.numberOfSelectedTags; i++) {
            UIImageView *selectedHeartImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kSelectedHeartImageName]];
            [selectedHeartImageView setFrame:CGRectMake(0, (i*selectedHeartImageView.image.size.height)+kHeartsMargin, selectedHeartImageView.image.size.width, selectedHeartImageView.image.size.height)];
            [self addSubview:selectedHeartImageView];
        }
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
