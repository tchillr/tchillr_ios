//
//  NavitiaHTTPClient.m
//  Tchillr
//
//  Created by Zouhair on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "NavitiaHTTPClient.h"
#import "NSDate+Tchillr.h"
// Model
#import "AFJSONRequestOperation.h"

@implementation NavitiaHTTPClient

#pragma mark Shared Instance
static NavitiaHTTPClient *sharedInstance;
+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedInstance = [[NavitiaHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.navitia.io/"]];
	}
}
+ (NavitiaHTTPClient *)sharedInstance {
	return sharedInstance;
}

#pragma mark Find Places
- (void)findPlacesNearLocation:(CLLocationCoordinate2D)location completion:(void (^)(BOOL success, NSArray *places, NSError *error))completion {
	NSString *requestPath = [NSString stringWithFormat:@"/v0/paris/places_nearby.json?uri=coord:%f:%f", location.longitude, location.latitude];
    
	NSURLRequest *request = [self requestWithMethod:@"GET"
											   path:requestPath
										 parameters:nil];
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

#pragma mark Find Route from point to point
- (void)findRouteFromLocation:(CLLocationCoordinate2D)origin toLocation:(CLLocationCoordinate2D)destination completion:(void (^)(BOOL success, NSArray *steps, NSError *error))completion {
    
	NSString *requestPath = [NSString stringWithFormat:@"/v0/paris/journeys.json?origin=coord:%.3f:%.3f&destination=coord:%.3f:%.3f&datetime=%@&forbidden_uris[]=commercial_mode:0x1&walking_distance=2000", origin.longitude, origin.latitude, destination.longitude, destination.latitude,[NSDate navitiaFormattedDate]];
	NSURLRequest *request = [self requestWithMethod:@"GET"
											   path:requestPath
										 parameters:nil];
    NSLog(@"Request : %@",[request description]);
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
																							completion(YES, nil, nil);
                                                                                            NSLog(@"JSON : %@",[JSON description]);
                                                                                        }
																						failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
																							completion(NO, nil, error);
                                                                                        }
                                         ];
    
    [operation start];
}

@end
