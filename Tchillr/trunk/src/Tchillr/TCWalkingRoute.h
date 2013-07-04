//
//  TCWalkingRoute.h
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

// Frameworks
#import <MapKit/MapKit.h>

@interface TCWalkingRoute : TCObject

#pragma mark Route
@property (strong, nonatomic, readonly) MKPolyline *polyline;

#pragma mark Steps
- (NSUInteger)numberOfSteps;
- (CLLocationCoordinate2D)startLocationForStepAtIndex:(NSUInteger)index;
- (CLLocationCoordinate2D)endLocationForStepAtIndex:(NSUInteger)index;

@end
