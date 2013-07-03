//
//  TCRoutesClient.m
//  Tchillr
//
//  Created by Zouhair on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCRouteClient.h"

@interface TCRouteClient ()

@end

@implementation TCRouteClient

#pragma mark Shared Instance
static TCRouteClient *sharedInstance;
+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedInstance = [[TCRouteClient alloc] init];
	}
}
+ (TCRouteClient *)sharedInstance {
	return sharedInstance;
}

#pragma mark Routing
- (void)findRouteFrom:(CLLocationCoordinate2D)fromLocation to:(CLLocationCoordinate2D)toLocation transport:(TCRouteTransport)transport completion:(void (^)(BOOL success, id route, NSError *error))completion {
	
}

@end
