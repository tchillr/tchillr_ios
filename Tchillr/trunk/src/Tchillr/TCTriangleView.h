//
//  TCTriangleView.h
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Tchillr.h"
#import "TCActivity.h"

@interface TCTriangleView : UIView

@property (nonatomic, assign) TCActivityColorStyle style;

#pragma mark Triangle drawer
+ (void)drawTriangleWithRect:(CGRect)rect andColor:(UIColor *)color;
+ (void) drawTriangleWithRect:(CGRect)rect andStyle:(TCActivityColorStyle)style;

@end
