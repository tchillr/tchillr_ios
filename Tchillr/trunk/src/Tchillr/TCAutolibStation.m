//
//  TCAutolibStation.m
//  Tchillr
//
//  Created by Zouhair on 08/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCAutolibStation.h"

// Utilities
CLLocationCoordinate2D CLLocationCoordinate2DMakeWithAutolibDictionary(NSDictionary *autolibDictionary);
CLLocation *CLLocationWithAutolibDictionary(NSDictionary *autolibDictionary);

@implementation TCAutolibStation

- (CLLocation *)location {
	return CLLocationWithAutolibDictionary(self.jsonDictionary);
}

@end

// Utilities
CLLocationCoordinate2D CLLocationCoordinate2DMakeWithAutolibDictionary(NSDictionary *autolibDictionary) {
	NSDictionary *fields = [autolibDictionary objectForKey:@"fields"];
	NSArray *locationArray = [fields objectForKey:@"field13"];
	return CLLocationCoordinate2DMake([[locationArray objectAtIndex:0] floatValue], [[locationArray objectAtIndex:1] floatValue]);
}
CLLocation *CLLocationWithAutolibDictionary(NSDictionary *autolibDictionary) {
	CLLocationCoordinate2D autolibLocationCoordinate = CLLocationCoordinate2DMakeWithAutolibDictionary(autolibDictionary);
	return [[CLLocation alloc] initWithLatitude:autolibLocationCoordinate.latitude longitude:autolibLocationCoordinate.longitude];
}
