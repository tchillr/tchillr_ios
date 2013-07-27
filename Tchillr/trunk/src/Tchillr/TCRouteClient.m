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
#import "TCRoute.h"
#import "SBJsonParser.h"
#import "TCVelibStation.h"
#import "TCAutolibStation.h"

@interface TCRouteClient ()

#pragma mark Routing

#pragma mark Velib Specifics
@property (strong, nonatomic) NSArray *velibStations;
- (NSUInteger)numberOfVelibStations;
- (TCVelibStation *)velibStationAtIndex:(NSUInteger)index;

#pragma mark Autolib Specifics
@property (strong, nonatomic) NSArray *autolibStations;
- (NSUInteger)numberOfAutolibStations;
- (TCAutolibStation *)autolibStationAtIndex:(NSUInteger)index;

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
- (void)findRouteFrom:(CLLocationCoordinate2D)fromLocation to:(CLLocationCoordinate2D)toLocation transport:(TCRouteTransport)transport completion:(void (^)(BOOL success, TCRoute *route, NSError *error))completion {
	NSString *requestString = [NSString stringWithFormat:
							   @"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&mode=%@&sensor=true",
							   fromLocation.latitude, fromLocation.longitude,
							   toLocation.latitude, toLocation.longitude,
							   NSStringFromTCRouteTransport(transport)];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
																							TCRoute *route = [TCRoute objectWithJsonDictionary:JSON];
																							[route setTransport:transport];
																							completion(YES, route, nil);
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
		_velibStations = [parser objectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"velib_paris" ofType:@"json"]]];
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
- (void)findAvailabilityForVelibStation:(TCVelibStation *)station completion:(void (^)(BOOL success, NSString *availability, NSError *error))completion {
	NSString *requestString = [NSString stringWithFormat:
							   @"https://api.jcdecaux.com/vls/v1/stations/%@?apiKey=%@&contract=Paris",
							   station.number,
							   @"46ec976a15e3d56b2c067ea5d3b90c38f5a75898"];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
																							NSNumber *availableBikes = [JSON objectForKey:@"available_bikes"];
																							NSNumber *availableBikeStands = [JSON objectForKey:@"available_bike_stands"];
																							NSInteger totalStands = [availableBikes integerValue] + [availableBikeStands integerValue];
																							station.availability = [NSString stringWithFormat:@"%@/%d", availableBikes, totalStands];
																							completion(YES, station.availability, nil);
                                                                                        }
																						failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
																							completion(NO, nil, error);
																						}
                                         ];
    
    [operation start];
}


#pragma mark Autolib Specifics
- (NSArray *)autolibStations {
	if (!_autolibStations) {
		SBJsonParser *parser = [[SBJsonParser alloc] init];
		_autolibStations = [parser objectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autolib_paris" ofType:@"json"]]];
	}
	return _autolibStations;
}
- (NSUInteger)numberOfAutolibStations {
	return [self.autolibStations count];
}
- (TCAutolibStation *)autolibStationAtIndex:(NSUInteger)index {
	return [TCAutolibStation objectWithJsonDictionary:[self.autolibStations objectAtIndex:index]];
}
- (TCAutolibStation *)nearestAutolibStationFrom:(CLLocation *)location {
	TCAutolibStation *nearestAutolibStation = nil;
	for (int i = 0; i < [self numberOfAutolibStations]; i++) {
		TCAutolibStation *autolibStation = [self autolibStationAtIndex:i];
		if (!nearestAutolibStation || [location distanceFromLocation:nearestAutolibStation.location] > [location distanceFromLocation:autolibStation.location]) {
			nearestAutolibStation = autolibStation;
		}
	}
	return nearestAutolibStation;
}
- (void)findAvailabilityForAutolibStation:(TCVelibStation *)station completion:(void (^)(BOOL success, NSString *availability, NSError *error))completion {
	
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

#pragma mark Utilities
NSString *NSStringFromTCRouteTransport(TCRouteTransport transport) {
	NSString *string = nil;
	switch (transport) {
		case TCRouteTransportAutolib:
			string = @"driving";
			break;
		case TCRouteTransportRATP:
			string = @"transit";
			break;
		case TCRouteTransportVelib:
			string = @"bicycling";
			break;
		case TCRouteTransportWalk:
			string = @"walking";
			break;
	}
	return string;
}
