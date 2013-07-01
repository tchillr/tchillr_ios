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

@interface TCRouteViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

#pragma mark Back Navigation
- (IBAction)popViewController:(id)sender;

#pragma mark User Location
@property (strong, nonatomic) CLLocationManager *userLocationManager;
- (void)startUpdatingUserLocation;

#pragma mark Map Management
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation TCRouteViewController

#pragma mark View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	[self startUpdatingUserLocation];
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

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	CLLocation *userLocation = [locations lastObject];
	[self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
	[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 300.00, 300.00)];
}

@end
