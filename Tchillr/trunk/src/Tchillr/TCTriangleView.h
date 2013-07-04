//
//  TCTriangleView.h
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Tchillr.h"


@interface TCTriangleView : UIView

@property (nonatomic, assign) TCColorStyle style;

#pragma mark Triangle drawer
+ (void) drawTriangleWithRect:(CGRect)rect andStyle:(TCColorStyle)style;
+ (void)drawTriangleWithRect:(CGRect)rect andColor:(UIColor *)color;

@end
