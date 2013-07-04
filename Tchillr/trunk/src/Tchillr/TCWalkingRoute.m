//
//  TCWalkingRoute.m
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCWalkingRoute.h"

#pragma mark Utilities
CLLocationCoordinate2D CLLocationCoordinate2DMakeFromDictionary(NSDictionary *locationDictionary);

@interface TCWalkingRoute ()

#pragma mark Route
@property (strong, nonatomic, readwrite) MKPolyline *polyline;

#pragma mark Steps
@property (nonatomic, readonly) NSArray *steps;

@end

@implementation TCWalkingRoute

#pragma mark Route
- (MKPolyline *)polyline {
	if (!_polyline) {
		NSUInteger numberOfCoordinates = self.numberOfSteps*2;
		CLLocationCoordinate2D coordinates[numberOfCoordinates];
		for (int i = 0; i < numberOfCoordinates/2; i++) {
			coordinates[i*2] = [self startLocationForStepAtIndex:i];
			coordinates[i*2+1] = [self endLocationForStepAtIndex:i];
		}
		_polyline = [MKPolyline polylineWithCoordinates:coordinates count:numberOfCoordinates];
	}
	return _polyline;
}

#pragma mark Steps
- (NSArray *)steps {
	NSArray *routes = [self.jsonDictionary objectForKey:@"routes"];
	NSDictionary *route = [routes lastObject];
	NSArray *legs = [route objectForKey:@"legs"];
	NSDictionary *leg = [legs lastObject];
	return [leg objectForKey:@"steps"];
}
- (NSUInteger)numberOfSteps {
	return [self.steps count];
}
- (NSDictionary *)stepAtIndex:(NSUInteger)index {
	return [self.steps objectAtIndex:index];
}
- (CLLocationCoordinate2D)startLocationForStepAtIndex:(NSUInteger)index {
	return CLLocationCoordinate2DMakeFromDictionary([[self stepAtIndex:index] objectForKey:@"start_location"]);
}
- (CLLocationCoordinate2D)endLocationForStepAtIndex:(NSUInteger)index {
	return CLLocationCoordinate2DMakeFromDictionary([[self stepAtIndex:index] objectForKey:@"end_location"]);
}

@end

#pragma mark Utilities
CLLocationCoordinate2D CLLocationCoordinate2DMakeFromDictionary(NSDictionary *locationDictionary) {
	return CLLocationCoordinate2DMake([[locationDictionary objectForKey:@"lat"] doubleValue], [[locationDictionary objectForKey:@"lng"] doubleValue]);
}