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

@end
