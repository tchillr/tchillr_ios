//
//  TCTransportAnnotationView.m
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTransportAnnotationView.h"

// Model
#import "TCTransportAnnotation.h"

// Views
#import "TCTransportPinView.h"

// Categories
#import "UIColor+Tchillr.h"

@interface TCTransportAnnotationView ()

@property (strong, nonatomic) TCTransportPinView *transportPinView;

@end

@implementation TCTransportAnnotationView

#pragma mark Lifecycle
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0.0f, 0.0f, 25.0f, 30.0f + TCTransportPinViewHeaderHeight);
		self.opaque = NO;
		
		self.transportPinView = [[TCTransportPinView alloc] initWithFrame:self.bounds];
		[self addSubview:self.transportPinView];
		
		if ([annotation isKindOfClass:[TCTransportAnnotation class]]) {
			TCTransportAnnotation *transportAnnotation = annotation;
			self.transportPinView.transportImage = UIImageWithTransport(transportAnnotation.transport);
			self.transportPinView.transportText = transportAnnotation.name;
		}
    }
    return self;
}
- (void)setAnnotation:(id<MKAnnotation>)annotation {
	[super setAnnotation:annotation];
	if ([annotation isKindOfClass:[TCTransportAnnotation class]]) {
		TCTransportAnnotation *transportAnnotation = annotation;
		self.transportPinView.transportImage = UIImageWithTransport(transportAnnotation.transport);
		self.transportPinView.transportText = transportAnnotation.name;
	}
}

@end
