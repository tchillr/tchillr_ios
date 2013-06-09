//
//  UIColor+BMAddings.m
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "UIColor+BMAddings.h"

@implementation UIColor (BMAddings)

+(UIColor *)colorWithCommaSeparatedRGBString:(NSString *)colorString {
    NSArray *colors = [colorString componentsSeparatedByString:@"	"];
    
    CGFloat redColor = [[colors objectAtIndex:0] floatValue];
    CGFloat greenColor = [[colors objectAtIndex:1] floatValue];
    CGFloat blueColor = [[colors objectAtIndex:2] floatValue];
    
    CGFloat alpha = 1;
    if([colors count] >= 4) {
        if(![[colors objectAtIndex:3] isEqualToString:@""]) {
            alpha = [[colors objectAtIndex:3] floatValue];
        }
    }
    
    return [UIColor colorWithRed:redColor/255.0 green:greenColor/255.0 blue:blueColor/255.0 alpha:alpha];
}

@end
