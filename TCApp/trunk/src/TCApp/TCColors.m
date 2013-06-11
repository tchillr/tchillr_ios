//
//  TCColors.m
//  TCApp
//
//  Created by Jad on 11/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "TCColors.h"
#import "TCColor.h"

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
        CGFloat alpha = 1.0;
        
        TCColor * color0 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:126.0/255.0 blue:80.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:60.0/255.0 green:58.0/255.0 blue:55.0/255.0 alpha:alpha]];
                                        
        TCColor * color1 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:129.0/255.0 green:157.0/255.0 blue:122.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:238.0/255.0 green:236.0/255.0 blue:216.0/255.0 alpha:alpha]];
        
        TCColor * color2 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:232.0/255.0 blue:145.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:57.0/255.0 green:57.0/255.0 blue:56.0/255.0 alpha:alpha]];
        
        TCColor * color3 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:101.0/255.0 green:119.0/255.0 blue:147.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:238.0/255.0 green:236.0/255.0 blue:216.0/255.0 alpha:alpha]];
        
        TCColor * color4 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:221.0/255.0 green:128.0/255.0 blue:124.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:57.0/255.0 green:57.0/255.0 blue:55.0/255.0 alpha:alpha]];
        
        TCColor * color5 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:57.0/255.0 blue:55.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:238.0/255.0 green:236.0/255.0 blue:216.0/255.0 alpha:alpha]];
        
        TCColor * color6 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:173.0/255.0 green:223.0/255.0 blue:221.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:57.0/255.0 green:57.0/255.0 blue:55.0/255.0 alpha:alpha]];
        
        TCColor * color7 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:94.0/255.0 green:87.0/255.0 blue:105.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:237.0/255.0 green:236.0/255.0 blue:215.0/255.0 alpha:alpha]];

        NSArray * colors = [NSArray arrayWithObjects:color0, color1, color2, color3, color4, color5, color6, color7, nil];
    return colors;    
}

+ (TCColor*) colorAtIndex:(NSInteger)index{
    return [[self colors] objectAtIndex:index];
}

@end
