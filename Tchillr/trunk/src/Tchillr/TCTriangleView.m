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

#pragma mark Triangle drawer
+ (void) drawTriangleWithRect:(CGRect)rect andStyle:(TCColorStyle)style{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint   (ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom middle point
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left point
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right point
    CGContextClosePath(ctx);
    
    UIColor * color = [UIColor tcColorWithStyle:style];
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
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor tcBlackSemiTransparent].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(ctx);
}

- (void)drawRect:(CGRect)rect
{
    [[self class] drawTriangleWithRect:rect andStyle:self.style];
}



@end
