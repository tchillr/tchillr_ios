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
- (void)findRouteFrom:(CLLocationCoordinate2D)fromLocation to:(CLLocationCoordinate2D)toLocation transport:(TCRouteTransport)transport completion:(void (^)(BOOL success, id route, NSError *error))completion;

#pragma mark Velib Specifics
- (TCVelibStation *)nearestVelibStationFrom:(CLLocation *)location;

@end
