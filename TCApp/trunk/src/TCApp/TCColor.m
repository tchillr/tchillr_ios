//
//  TCColor.m
//  TCApp
//
//  Created by Jad on 11/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "TCColor.h"

@implementation TCColor

@synthesize backgroundColor = _backgroundColor;
@synthesize titleColor = _titleColor;

- (id) initWithBackgroundColor:(UIColor *) backgroundColor andTitleColor:(UIColor *) titleColor{
    self = [super init];
    if (self) {
        _backgroundColor = backgroundColor;
        _titleColor = titleColor;
    }
    return self;
}

@end
