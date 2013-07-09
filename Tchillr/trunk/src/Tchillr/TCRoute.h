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

#import "TCRouteClient.h"

@interface TCRoute : TCObject

#pragma mark Route
@property (assign, nonatomic) TCRouteTransport transport;
@property (strong, nonatomic, readonly) MKPolyline *polyline;

#pragma mark Steps
- (NSUInteger)numberOfSteps;
- (CLLocationCoordinate2D)startLocationForStepAtIndex:(NSUInteger)index;
- (CLLocationCoordinate2D)endLocationForStepAtIndex:(NSUInteger)index;

@end
