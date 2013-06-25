//
//  TCLocationAnnotationView.m
//  Tchillr
//
//  Created by Jad on 21/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCLocationAnnotationView.h"
#import "TCColors.h"

@implementation TCLocationAnnotationView

@synthesize style = _style;

- (id)initWithAnnotation:(id <MKAnnotation>) annotation reuseIdentifier:(NSString *) reuseIdentifier {
    self = [super initWithAnnotation: annotation reuseIdentifier: reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 20, 25);
        self.opaque = NO;
        self.alpha = 1.0;
    }
    return self;
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
    
    CGContextSetStrokeColorWithColor(ctx, [TCColors tcBlackSemiTransparent].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextStrokePath(ctx);
}


@end
