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
#import "TCRoute.h"
#import "TCTransportAnnotation.h"

// Categories
#import "UIColor+Tchillr.h"

// Views & Controls
#import "TCLocationAnnotationView.h"
#import "TCTransportAnnotationView.h"

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
@property (assign, nonatomic) TCRouteTransport transport;
@property (strong, nonatomic) id route;
@property (strong, nonatomic) MKPolylineView *polylineView;

#pragma mark Map Management
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation TCRouteViewController

#pragma mark View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	[self pinActivity];
	[self startUpdatingUserLocation];
	self.transport = TCRouteTransportWalk;
	[[TCRouteClient sharedInstance] findRouteFrom:self.mapView.userLocation.coordinate
											   to:self.activityLocation.coordinate
										transport:self.transport
									   completion:^(BOOL success, id route, NSError *error) {
										   self.route = route;
										   switch (self.transport) {
											   case TCRouteTransportWalk: {
												   TCWalkingRoute *walkingRoute = self.route;
												   [self.mapView addOverlay:walkingRoute.polyline];
											   }  break;
												default:
												   break;
										   }
									   }];
	TCVelibStation *nearestVelibStation = [[TCRouteClient sharedInstance] nearestVelibStationFrom:self.mapView.userLocation.location];
	
	TCTransportAnnotation* annotation = [[TCTransportAnnotation alloc] initWithTransport:self.transport name:nearestVelibStation.name address:nearestVelibStation.address coordinate:nearestVelibStation.location.coordinate];
	[self.mapView addAnnotation:annotation];
	
	
	nearestVelibStation = [[TCRouteClient sharedInstance] nearestVelibStationFrom:self.activityLocation];
	
	annotation = [[TCTransportAnnotation alloc] initWithTransport:self.transport name:nearestVelibStation.name address:nearestVelibStation.address coordinate:nearestVelibStation.location.coordinate];
	[self.mapView addAnnotation:annotation];
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
	
	[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(middleLocation, distance, distance)];
}

#pragma mark MKMapViewDelegate
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
	MKOverlayView* overlayView = nil;
	
	if(!self.polylineView) {
		self.polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
		self.polylineView.fillColor = [UIColor tcWhite];
		self.polylineView.strokeColor = [UIColor tcBlack];
		self.polylineView.lineWidth = 5.0;
		self.polylineView.lineCap = kCGLineCapRound;
		self.polylineView.lineJoin = kCGLineJoinRound;
		self.polylineView.lineDashPattern = @[@10.0,@10.0];
	}
	overlayView = self.polylineView;
	
	return overlayView;
}

#warning - À Remonter dans une classe parente de TCRouteVC et TCMapVC
- (TCLocationAnnotationViewSizeType)annotationSizeTypeForActivity:(TCActivity *)activity {
    TCLocationAnnotationViewSizeType sizeType;
    if ([activity.score intValue] < 6) {
        sizeType = TCLocationAnnotationViewSizeTypeSmall;
    }
    else if ([activity.score intValue] < 11) {
        sizeType = TCLocationAnnotationViewSizeTypeMedium;
    }
    else {
        sizeType = TCLocationAnnotationViewSizeTypeLarge;
    }
    return sizeType;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	id annotationView = nil;
	if ([annotation isMemberOfClass:[TCLocationAnnotation class]]) {
        TCLocationAnnotationView *locationAnnotationView = (TCLocationAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TCLocationAnnotationView class])];
        if (!locationAnnotationView) {
            locationAnnotationView = [[TCLocationAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TCLocationAnnotationView class]) andSize:[self annotationSizeTypeForActivity:self.activity]];
            locationAnnotationView.style = TCColorStyleMusic;
            locationAnnotationView.enabled = YES;
            locationAnnotationView.canShowCallout = NO;
        }
		else {
            locationAnnotationView.annotation = annotation;
        }
		annotationView = locationAnnotationView;
    }
	else if ([annotation isMemberOfClass:[TCTransportAnnotation class]]) {
		TCTransportAnnotationView *transportAnnotationView = (TCTransportAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TCTransportAnnotationView class])];
		if (!transportAnnotationView) {
			transportAnnotationView = [[TCTransportAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TCTransportAnnotationView class])];
		}
		else {
			transportAnnotationView.annotation = annotation;
		}
		annotationView = transportAnnotationView;
	}
	return annotationView;
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
