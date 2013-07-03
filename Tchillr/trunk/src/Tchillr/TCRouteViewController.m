//
//  TCRouteViewController.m
//  Tchillr
//
//  Created by Jad on 26/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCRouteViewController.h"

// Frameworks
#import <MapKit/MapKit.h>

// Model
#import "TCActivity.h"
#import "TCLocationAnnotation.h"
#import "NavitiaHTTPClient.h"

#pragma mark Utilities
CLLocationCoordinate2D midPoint(CLLocationCoordinate2D locationA, CLLocationCoordinate2D locationB);

@interface TCRouteViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

#pragma mark Back Navigation
- (IBAction)popViewController:(id)sender;

#pragma mark User Location
@property (strong, nonatomic) CLLocationManager *userLocationManager;
- (void)startUpdatingUserLocation;

#pragma mark Activity Location
- (CLLocation *)activityLocation;
- (void)pinActivity;

#pragma mark Map Management
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation TCRouteViewController

#pragma mark View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	[self pinActivity];
	[self startUpdatingUserLocation];
	
	[[NavitiaHTTPClient sharedInstance] findPlacesNearLocation:self.activityLocation.coordinate
													completion:^(BOOL success, NSArray *places, NSError *error) {
														
													}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Back Navigation
- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark User Location
- (CLLocationManager *)userLocationManager {
	if (!_userLocationManager) {
		_userLocationManager = [[CLLocationManager alloc] init];
		[_userLocationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
		[_userLocationManager setDistanceFilter:2.0];
		[_userLocationManager setDelegate:self];
	}
	return _userLocationManager;
}
- (void)startUpdatingUserLocation {
	if ([CLLocationManager locationServicesEnabled]) {
		[self.userLocationManager startUpdatingLocation];
	}
}

#pragma mark Activity Location
- (CLLocation *)activityLocation {
	return [[CLLocation alloc] initWithLatitude:self.activity.latitude longitude:self.activity.longitude];
}
- (void)pinActivity {
	TCLocationAnnotation* annotation = [[TCLocationAnnotation alloc] initWithName:self.activity.name address:self.activity.fullAddress coordinate:CLLocationCoordinate2DMake(self.activity.latitude, self.activity.longitude)];
	[self.mapView addAnnotation:annotation];
}

#pragma mark Map Management

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	CLLocation *userLocation = [locations lastObject];
	[self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
	
	// Distance between user and activity
	CLLocationDistance distance = [userLocation distanceFromLocation:self.activityLocation];
	
	// Center point (user, activity)
	CLLocationCoordinate2D middleLocation = midPoint(userLocation.coordinate, self.activityLocation.coordinate);
	
	[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(middleLocation, distance/2, distance/2)];
}

@end

#pragma mark Utilities
CLLocationCoordinate2D midPoint(CLLocationCoordinate2D locationA, CLLocationCoordinate2D locationB) {
    double longitude1 = locationA.longitude * M_PI / 180.0;
    double longitude2 = locationB.longitude * M_PI / 180.0;
	
    double latitutde1 = locationA.latitude * M_PI / 180.0;
    double latitutde2 = locationB.latitude * M_PI / 180.0;
	
    double longitudeDelta = longitude2 - longitude1;
	
    double x = cos(latitutde2) * cos(longitudeDelta);
    double y = cos(latitutde2) * sin(longitudeDelta);
	
    double latitude3 = atan2( sin(latitutde1) + sin(latitutde2), sqrt((cos(latitutde1) + x) * (cos(latitutde1) + x) + y * y) );
    double longitude3 = longitude1 + atan2(y, cos(latitutde1) + x);
	
    return CLLocationCoordinate2DMake(latitude3 * 180 / M_PI, longitude3 * 180 / M_PI);
}
