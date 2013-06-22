//
//  TCTagView.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTagView.h"
#import "TCConstants.h"

@implementation TCTagView

@synthesize userInterest = _userInterest;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setUserInterest:(BOOL)userInterest{
    _userInterest = userInterest;
   // [self.heartImageView setImage:(_userInterest) ? kHeartImageSelected : kHeartImage];
}

@end
