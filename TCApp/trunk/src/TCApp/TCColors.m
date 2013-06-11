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
        
        TCColor * color0 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:145.0/255.0 green:106/255.0 blue:146.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];
                                        
        TCColor * color1 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:129.0/255.0 green:157.0/255.0 blue:122.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];
        
        TCColor * color2 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:133.0/255.0 blue:108.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];
        
        TCColor * color3 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:33.0/255.0 green:38.0/255.0 blue:98.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];
        
        TCColor * color4 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:70.0/255.0 blue:78.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];
        
        TCColor * color5 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:82.0/255.0 green:34.0/255.0 blue:64.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];
        
        TCColor * color6 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:120.0/255.0 green:200.0/255.0 blue:218.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];
        
        TCColor * color7 = [[TCColor alloc] initWithBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:129.0/255.0 blue:146.0/255.0 alpha:alpha] andTitleColor:[UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:alpha]];

        NSArray * colors = [NSArray arrayWithObjects:color0, color1, color2, color3, color4, color5, color6, color7, nil];
    return colors;    
}

+ (TCColor*) colorAtIndex:(NSInteger)index{
    return [[self colors] objectAtIndex:index];
}

@end
