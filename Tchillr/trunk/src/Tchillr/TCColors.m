//
//  TCColors.m
//  TCApp
//
//  Created by Jad on 11/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "TCColors.h"

@implementation TCColors

@synthesize colors = _colors;

#pragma mark Singleton
static TCColors *sharedColors;

+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedColors = [[TCColors alloc] init];
	}
}

+ (NSArray *)colors{
    CGFloat alpha = 1;

    UIColor * color0 = [UIColor colorWithRed:242.0/255.0 green:106.0/255.0 blue:120.0/255.0 alpha:alpha];
    UIColor * color1 = [UIColor colorWithRed:96.0/255.0  green:86.0/255.0  blue:152.0/255.0 alpha:alpha];
    UIColor * color2 = [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:123.0/255.0 alpha:alpha];
    UIColor * color3 = [UIColor colorWithRed:247.0/255.0 green:146.0/255.0 blue:113.0/255.0 alpha:alpha];
    UIColor * color4 = [UIColor colorWithRed:106.0/255.0 green:201.0/255.0 blue:217.0/255.0 alpha:alpha];
    UIColor * color5 = [UIColor colorWithRed:131.0/255.0 green:191.0/255.0 blue:149.0/255.0 alpha:alpha];
    UIColor * color6 = [UIColor colorWithRed:147.0/255.0 green:108.0/255.0 blue:163.0/255.0 alpha:alpha];
    return [NSArray arrayWithObjects:color0, color1, color2, color3, color4, color5, color6, nil];
}

+ (UIColor*) colorAtIndex:(NSInteger)index{
    return [[self colors] objectAtIndex:index];
}

@end
