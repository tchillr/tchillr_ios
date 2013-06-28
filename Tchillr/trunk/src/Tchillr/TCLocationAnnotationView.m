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
    [TCTriangleView drawTriangleWithRect:rect andStyle:self.style];
}


@end
