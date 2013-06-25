//
//  UIColor+Tchillr.h
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TCColorStyleMusic,
    TCColorStyleCinema,
    TCColorStyleExpo,
    TCColorStyleNature
} TCColorStyle;

@interface UIColor (Tchillr)

+ (UIColor *)tcColorWithStyle:(TCColorStyle)style;
+ (UIColor *)tcBlack;
+ (UIColor *)tcWhite;
+ (UIColor *)tcBlackSemiTransparent;

@end
