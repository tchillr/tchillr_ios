//
//  UIColor+Tchillr.m
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "UIColor+Tchillr.h"

@implementation UIColor (Tchillr)

+ (NSArray *)tcColors {
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

+ (UIColor *)tcColorWithStyle:(TCColorStyle)style {
	UIColor *color = nil;
	switch (style) {
		case TCColorStyleMusic:
			color = [UIColor colorWithRed:242.0/255.0 green:106.0/255.0 blue:120.0/255.0 alpha:1.0];
			break;
		case TCColorStyleCinema:
			color = [UIColor colorWithRed:96.0/255.0  green:86.0/255.0  blue:152.0/255.0 alpha:1.0];
			break;
		case TCColorStyleExpo:
			color = [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:123.0/255.0 alpha:1.0];
			break;
		case TCColorStyleNature:
			color = [UIColor colorWithRed:247.0/255.0 green:146.0/255.0 blue:113.0/255.0 alpha:1.0];
			break;
		default:
			color = [UIColor tcWhite];
			break;
	}
	return color;
}
+ (UIColor*)tcColorAtIndex:(NSInteger)index{
    return [[self tcColors] objectAtIndex:index];
}

+ (UIColor*) tcBlack {
    return [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:52.0/255.0 alpha:1];
}

+ (UIColor*) tcBlackSemiTransparent {
    return [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:52.0/255.0 alpha:0.8];
}

+ (UIColor*) tcWhite {
    return [UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:234.0/255.0 alpha:1];
}

@end
