//
//  UIColor+Tchillr.h
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCActivity.h"

@interface UIColor (Tchillr)

+ (NSArray *)tcColorsWithAlpha:(CGFloat)alpha;
+ (UIColor *)tcColorWithStyle:(TCActivityColorStyle)style;
+ (UIColor *)tcColorWithStyle:(TCActivityColorStyle)style alpha:(CGFloat)alpha;
+ (UIColor *)tcBlack;
+ (UIColor *)tcWhite;
+ (UIColor *)tcBlackSemiTransparent;

@end
