//
//  EMStretchableImageView.m
//  EuroMillions
//
//  Created by  on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BMStretchableImageView.h"

@implementation BMStretchableImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if(self) {
        UIImage *stretchedBackgroundImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [self setImage:stretchedBackgroundImage];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIImage *stretchedBackgroundImage = [self.image stretchableImageWithLeftCapWidth:self.image.size.width/2 topCapHeight:self.image.size.height/2];
    [self setImage:stretchedBackgroundImage];
}

@end
