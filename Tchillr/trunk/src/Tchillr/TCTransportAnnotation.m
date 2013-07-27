//
//  TCTransportAnnoation.m
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTransportAnnotation.h"

@interface TCTransportAnnotation ()

@property (assign, nonatomic, readwrite) TCRouteTransport transport;
@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSString *address;
@property (assign, nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end

@implementation TCTransportAnnotation

- (id)initWithTransport:(TCRouteTransport)transport name:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate {
	self = [self init];
	if (self) {
		self.transport = transport;
		self.name = name;
		self.address = address;
		self.coordinate = coordinate;
	}
	return self;
}
- (NSString *)title {
	return self.name;
}
- (NSString *)subtitle {
	return self.address;
}

@end

UIImage *UIImageWithTransport(TCRouteTransport transport) {
	UIImage *image = nil;
	switch (transport) {
		case TCRouteTransportWalk:
			image = [UIImage imageNamed:@"walker"];
			break;
		case TCRouteTransportVelib:
			image = [UIImage imageNamed:@"velib"];
			break;
		case TCRouteTransportAutolib:
			image = [UIImage imageNamed:@"auto"];
			break;
		case TCRouteTransportRATP:
			image = [UIImage imageNamed:@"bus"];
			break;
	}
	return image;
}
