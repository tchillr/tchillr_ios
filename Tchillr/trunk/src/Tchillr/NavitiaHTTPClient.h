//
//  NavitiaHTTPClient.h
//  Tchillr
//
//  Created by Zouhair on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "AFHTTPClient.h"

// Frameworks
#import <MapKit/MapKit.h>

@interface NavitiaHTTPClient : AFHTTPClient

#pragma mark Shared Instance
+ (NavitiaHTTPClient *)sharedInstance;

#pragma mark Find Places
- (void)findPlacesNearLocation:(CLLocationCoordinate2D)location completion:(void (^)(BOOL success, NSArray *places, NSError *error))completion;
#pragma mark Find Route from point to point
- (void)findRouteFromLocation:(CLLocationCoordinate2D)origin toLocation:(CLLocationCoordinate2D)destination completion:(void (^)(BOOL success, NSArray *steps, NSError *error))completion;

@end
