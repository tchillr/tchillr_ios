//
//  TCTransportPinView.m
//  Tchillr
//
//  Created by Zouhair on 10/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTransportPinView.h"

// Categories
#import "UIColor+Tchillr.h"
#import <QuartzCore/QuartzCore.h>

CGFloat const TCTransportPinViewHeaderHeight = 15.0f;

@interface TCTransportPinView ()

@property (strong, nonatomic) UIImageView *transportImageView;
@property (strong, nonatomic) UILabel *transportTextLabel;

@end

@implementation TCTransportPinView

#pragma mark Lifecycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.opaque = NO;
		
		self.layer.rasterizationScale = [UIScreen mainScreen].scale;
		self.layer.shouldRasterize = YES;
    }
    return self;
}

#pragma mark Drawing
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect) + TCTransportPinViewHeaderHeight);
	CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect) + TCTransportPinViewHeaderHeight);
    CGContextClosePath(ctx);
	
    CGContextSetLineWidth(ctx, 1.0);
	CGContextSetFillColorWithColor(ctx, [UIColor tcBlack].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor tcWhite].CGColor);
	
	CGContextDrawPath(ctx, kCGPathFillStroke);
}
- (void)layoutSubviews {
	[super layoutSubviews];
	[self.transportImageView setFrame:CGRectMake(self.bounds.origin.x + 5.0,
												self.bounds.origin.y + TCTransportPinViewHeaderHeight,
												self.bounds.size.width - 10.0,
												 (self.bounds.size.height - TCTransportPinViewHeaderHeight)/2 - 2.0)];
	[self.transportTextLabel setFrame:CGRectMake(self.bounds.origin.x,
												 self.bounds.origin.y + 2.0,
												self.bounds.size.width,
												 TCTransportPinViewHeaderHeight)];
}

#pragma mark Properties
- (UIImageView *)transportImageView {
	if (!_transportImageView) {
		_transportImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:_transportImageView];
		
		[_transportImageView setContentMode:UIViewContentModeScaleAspectFit];
	}
	return _transportImageView;
}
- (UILabel *)transportTextLabel {
	if (!_transportTextLabel) {
		_transportTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self addSubview:_transportTextLabel];
		
		[_transportTextLabel setBackgroundColor:[UIColor clearColor]];
		[_transportTextLabel setTextColor:[UIColor tcWhite]];
		[_transportTextLabel setTextAlignment:NSTextAlignmentCenter];
        [_transportTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:10]];
	}
	return _transportTextLabel;
}
@dynamic transportImage;
- (UIImage *)transportImage {
	return self.transportImageView.image;
}
- (void)setTransportImage:(UIImage *)transportImage {
	[self.transportImageView setImage:transportImage];
}
@dynamic transportText;
- (NSString *)transportText {
	return self.transportTextLabel.text;
}
- (void)setTransportText:(NSString *)transportText {
	[self.transportTextLabel setText:transportText];
}

@end
