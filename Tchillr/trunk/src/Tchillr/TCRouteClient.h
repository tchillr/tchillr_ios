//
//  TCRoutesClient.h
//  Tchillr
//
//  Created by Zouhair on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
#import <MapKit/MapKit.h>

// Model
@class TCRoute;
@class TCVelibStation;
@class TCAutolibStation;


typedef enum {
	TCRouteTransportWalk,
	TCRouteTransportRATP,
	TCRouteTransportVelib,
	TCRouteTransportAutolib
} TCRouteTransport;

@class TCVelibStation;

@interface TCRouteClient : NSObject

#pragma mark Shared Instance
+ (TCRouteClient *)sharedInstance;

#pragma mark Routing
- (void)findRouteFrom:(CLLocationCoordinate2D)fromLocation to:(CLLocationCoordinate2D)toLocation transport:(TCRouteTransport)transport completion:(void (^)(BOOL success, TCRoute *route, NSError *error))completion;

#pragma mark Velib Specifics
- (TCVelibStation *)nearestVelibStationFrom:(CLLocation *)location;

#pragma mark Autolib Specifics
- (TCAutolibStation *)nearestAutolibStationFrom:(CLLocation *)location;

@end

#pragma mark Utilities
NSString *NSStringFromTCRouteTransport(TCRouteTransport transport);
