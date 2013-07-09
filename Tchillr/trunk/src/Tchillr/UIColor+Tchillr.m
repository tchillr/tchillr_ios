//
//  UIColor+Tchillr.m
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "UIColor+Tchillr.h"

#define kColorPink(alpha)   [UIColor colorWithRed:242.0/255.0 green:106.0/255.0 blue:120.0/255.0 alpha:alpha]
#define kColorPurple(alpha) [UIColor colorWithRed:96.0/255.0  green:86.0/255.0  blue:152.0/255.0 alpha:alpha]
#define kColorYellow(alpha) [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:123.0/255.0 alpha:alpha]
#define kColorOrange(alpha) [UIColor colorWithRed:247.0/255.0 green:146.0/255.0 blue:113.0/255.0 alpha:alpha]
#define kColorBlue(alpha)   [UIColor colorWithRed:106.0/255.0 green:201.0/255.0 blue:217.0/255.0 alpha:alpha]
#define kColorGreen(alpha)  [UIColor colorWithRed:131.0/255.0 green:191.0/255.0 blue:149.0/255.0 alpha:alpha]

@implementation UIColor (Tchillr)

+ (NSArray *)tcColors {
    return [self tcColorsWithAlpha:1.0];
}
+ (NSArray *)tcColorsWithAlpha:(CGFloat)alpha {
    UIColor * color0 = kColorPink(alpha);
    UIColor * color1 = kColorBlue(alpha);
    UIColor * color2 = kColorYellow(alpha);
    UIColor * color3 = kColorGreen(alpha);
    UIColor * color4 = kColorPurple(alpha);
    UIColor * color5 = kColorOrange(alpha);
    return [NSArray arrayWithObjects:color0, color1, color2, color3, color4, color5, nil];
}

+ (UIColor *)tcColorWithStyle:(TCActivityColorStyle)style {
	return [self tcColorWithStyle:style alpha:1.0];
}

+ (UIColor *)tcColorWithStyle:(TCActivityColorStyle)style alpha:(CGFloat)alpha {
	UIColor *color = nil;
	switch (style) {
		case TCActivityColorStyleMusique:
			color = kColorPink(alpha);
			break;
		case TCActivityColorStyleActivites:
			color = kColorBlue(alpha);
			break;
		case TCActivityColorStyleEvenements:
			color = kColorYellow(alpha);
			break;
		case TCActivityColorStyleNature:
			color = kColorGreen(alpha);
			break;
        case TCActivityColorStyleCulture:
            color = kColorPurple(alpha);
			break;
        case TCActivityColorStyleSpectacles:
            color = kColorOrange(alpha);
			break;
		default:
			color = [UIColor tcWhite];
			break;
	}
	return color;
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
