//
//  TCVelibStation.m
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCVelibStation.h"

// Utilities
CLLocationCoordinate2D CLLocationCoordinate2DMakeWithVelibDictionary(NSDictionary *velibDictionary);
CLLocation *CLLocationWithVelibDictionary(NSDictionary *velibDictionary);

@implementation TCVelibStation

- (NSString *)name {
	return [self.jsonDictionary objectForKey:@"name"];
}
- (NSString *)address {
	return [self.jsonDictionary objectForKey:@"address"];
}
- (NSNumber *)number {
	return [self.jsonDictionary objectForKey:@"number"];
}
- (CLLocation *)location {
	return CLLocationWithVelibDictionary(self.jsonDictionary);
}

@end

// Utilities
CLLocationCoordinate2D CLLocationCoordinate2DMakeWithVelibDictionary(NSDictionary *velibDictionary) {
	return CLLocationCoordinate2DMake([[velibDictionary objectForKey:@"latitude"] floatValue], [[velibDictionary objectForKey:@"longitude"] floatValue]);
}
CLLocation *CLLocationWithVelibDictionary(NSDictionary *velibDictionary) {
	CLLocationCoordinate2D velibLocationCoordinate = CLLocationCoordinate2DMakeWithVelibDictionary(velibDictionary);
	return [[CLLocation alloc] initWithLatitude:velibLocationCoordinate.latitude longitude:velibLocationCoordinate.longitude];
}
