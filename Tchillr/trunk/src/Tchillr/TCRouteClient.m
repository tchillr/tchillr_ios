//
//  TCRoutesClient.m
//  Tchillr
//
//  Created by Zouhair on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCRouteClient.h"

// Model
#import "AFJSONRequestOperation.h"
#import "TCWalkingRoute.h"
#import "SBJsonParser.h"
#import "TCVelibStation.h"

@interface TCRouteClient ()

#pragma mark Routing
- (void)findWalkingRouteFrom:(CLLocationCoordinate2D)fromLocation to:(CLLocationCoordinate2D)toLocation completion:(void (^)(BOOL success, TCWalkingRoute *route, NSError *error))completion;

#pragma mark Velib Specifics
@property (strong, nonatomic) NSArray *velibStations;
- (NSUInteger)numberOfVelibStations;
- (TCVelibStation *)velibStationAtIndex:(NSUInteger)index;

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
	switch (transport) {
		case TCRouteTransportWalk:
			[self findWalkingRouteFrom:fromLocation to:toLocation completion:completion];
			break;
		default:
			break;
	}
}
- (void)findWalkingRouteFrom:(CLLocationCoordinate2D)fromLocation to:(CLLocationCoordinate2D)toLocation completion:(void (^)(BOOL success, TCWalkingRoute *route, NSError *error))completion {
	NSString *requestString = [NSString stringWithFormat:
							   @"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&mode=bicycling&sensor=true",
							   fromLocation.latitude, fromLocation.longitude,
							   toLocation.latitude, toLocation.longitude];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
																							TCWalkingRoute *walkingRoute = [TCWalkingRoute objectWithJsonDictionary:JSON];
																							completion(YES, walkingRoute, nil);
                                                                                        }
																						failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
																							completion(NO, nil, error);
                                                                                        }
                                         ];
    
    [operation start];
}

#pragma mark Velib Specifics
- (NSArray *)velibStations {
	if (!_velibStations) {
		SBJsonParser *parser = [[SBJsonParser alloc] init];
		_velibStations = [parser objectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Paris" ofType:@"json"]]];
	}
	return _velibStations;
}
- (NSUInteger)numberOfVelibStations {
	return [self.velibStations count];
}
- (TCVelibStation *)velibStationAtIndex:(NSUInteger)index {
	return [TCVelibStation objectWithJsonDictionary:[self.velibStations objectAtIndex:index]];
}
- (TCVelibStation *)nearestVelibStationFrom:(CLLocation *)location {
	TCVelibStation *nearestVelibStation = nil;
	for (int i = 0; i < [self numberOfVelibStations]; i++) {
		TCVelibStation *velibStation = [self velibStationAtIndex:i];
		if (!nearestVelibStation || [location distanceFromLocation:nearestVelibStation.location] > [location distanceFromLocation:velibStation.location]) {
			nearestVelibStation = velibStation;
		}
	}
	return nearestVelibStation;
}

#pragma mark RATP - Find Places
- (void)findPlacesNearLocation:(CLLocationCoordinate2D)location completion:(void (^)(BOOL success, NSArray *places, NSError *error))completion {
	NSString *requestString = [NSString stringWithFormat:@"http://api.navitia.io/v0/paris/places_nearby.json?uri=coord:%f:%f", location.latitude, location.longitude];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
																							completion(YES, nil, nil);
                                                                                        }
																						failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
																							completion(NO, nil, error);
                                                                                        }
                                         ];
    
    [operation start];
}

@end
