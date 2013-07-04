//
//  TCTransportAnnotationView.m
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTransportAnnotationView.h"

// Views
#import "TCTriangleView.h"

// Categories
#import "UIColor+Tchillr.h"

@implementation TCTransportAnnotationView

#pragma mark Lifecycle
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 25.0, 30.0);
		self.opaque = NO;
    }
    return self;
}

#pragma mark Drawing
- (void)drawRect:(CGRect)rect {
    [TCTriangleView drawTriangleWithRect:rect andColor:[UIColor tcBlack]];
}

@end
