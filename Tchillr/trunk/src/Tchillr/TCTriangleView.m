//
//  TCTriangleView.m
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTriangleView.h"

@implementation TCTriangleView

@synthesize style = _style;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.opaque = NO;
    self.alpha = 1.0;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint   (ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom middle point
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left point
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right point
    CGContextClosePath(ctx);
    
    UIColor * color = [TCColors colorAtIndex:self.style];
    if (CGColorGetNumberOfComponents(color.CGColor) == 2) {
        const CGFloat *colorComponents = CGColorGetComponents(color.CGColor);
        CGContextSetRGBFillColor(ctx, colorComponents[0], colorComponents[0], colorComponents[0], colorComponents[1]);
    }
    else if (CGColorGetNumberOfComponents(color.CGColor) == 4) {
        const CGFloat * colorComponents = CGColorGetComponents(color.CGColor);
        CGContextSetRGBFillColor(ctx, colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]);
    }
    else {
        NSLog(@"Color not recognized");
    }
    CGContextFillPath(ctx);
}



@end
