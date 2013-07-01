//
//  TCLocationAnnotationView.m
//  Tchillr
//
//  Created by Jad on 21/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCLocationAnnotationView.h"
#import "TCTriangleView.h"
#import "UIColor+Tchillr.h"

@implementation TCLocationAnnotationView

@synthesize style = _style;
@synthesize sizeType = _sizeType;

#pragma mark Lifecycle
- (id)initWithAnnotation:(id <MKAnnotation>) annotation reuseIdentifier:(NSString *) reuseIdentifier andSize:(TCLocationAnnotationViewSizeType)sizeType{
    self = [super initWithAnnotation: annotation reuseIdentifier: reuseIdentifier];
    if (self) {
        self.sizeType = sizeType;
        CGSize size = [self sizeFromType];
        self.frame = CGRectMake(0, 0, size.width, size.height);
        self.opaque = NO;
        self.alpha = 1.0;
    }
    return self;
}

#pragma mark Drawing
- (void)drawRect:(CGRect)rect {
    [TCTriangleView drawTriangleWithRect:rect andStyle:self.style];
}

#pragma mark Size triangle
- (CGSize)sizeFromType {
    CGSize size = CGSizeZero;
    switch (self.sizeType) {
        case TCLocationAnnotationViewSizeTypeSmall:
            size = CGSizeMake(15, 20);
            break;
        case TCLocationAnnotationViewSizeTypeMedium:
            size = CGSizeMake(20, 25);
            break;
        case TCLocationAnnotationViewSizeTypeLarge:
            size = CGSizeMake(25, 30);
            break;
        default:
            break;
    }
    return size;
}


@end
