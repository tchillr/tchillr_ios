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
#import "TCTransportAnnotation.h"
#import "TCRouteClient.h"
#import "TCRoute.h"
#import "TCVelibStation.h"
#import "TCAutolibStation.h"

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
@property (strong, nonatomic) NSMutableSet *routes;
@property (strong, nonatomic) MKPolylineView *polylineView;

#pragma mark Map Management
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (void)reloadData;

#pragma mark Route Types Selection
@property (weak, nonatomic) IBOutlet UIButton *autolibButton;
@property (weak, nonatomic) IBOutlet UIButton *ratpButton;
@property (weak, nonatomic) IBOutlet UIButton *velibButton;
@property (weak, nonatomic) IBOutlet UIButton *walkingButton;
@property (weak, nonatomic) IBOutlet UIImageView *routeTransportArrow;

- (IBAction)switchCurrentTransport:(UIButton *)sender;
@property (weak, nonatomic) UIButton *currentButton;
@property (assign, nonatomic, readonly) TCRouteTransport currentTransport;

@end

@implementation TCRouteViewController

#pragma mark View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setCurrentButton:self.walkingButton];
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
- (NSMutableSet *)routes {
	if (!_routes) {
		_routes = [NSMutableSet set];
	}
	return _routes;
}
- (TCRoute *)routeForOverlay:(id<MKOverlay>)overlay {
	return [[self.routes objectsPassingTest:^BOOL(TCRoute *route, BOOL *stop) {
		return [route.polyline isEqual:overlay];
	}] anyObject];
}

#pragma mark Map Management
- (void)reloadData {
	NSIndexSet *transportAnnotationsIndexes = [self.mapView.annotations indexesOfObjectsPassingTest:^BOOL(id<MKAnnotation> annotation, NSUInteger idx, BOOL *stop) {
		return [annotation isKindOfClass:[TCTransportAnnotation class]];
	}];
	[self.mapView removeAnnotations:[self.mapView.annotations objectsAtIndexes:transportAnnotationsIndexes]];
	[self.mapView removeOverlays:self.mapView.overlays];
	
	[self.routes removeAllObjects];
	
	[self pinActivity];
	[self startUpdatingUserLocation];
	
	switch (self.currentTransport) {
		case TCRouteTransportWalk: {
			[[TCRouteClient sharedInstance] findRouteFrom:self.mapView.userLocation.coordinate
													   to:self.activityLocation.coordinate
												transport:TCRouteTransportWalk
											   completion:^(BOOL success, TCRoute *route, NSError *error) {
												   [self.routes addObject:route];
												   [self.mapView addOverlay:route.polyline];
											   }];
		} break;
		case TCRouteTransportVelib: {
			TCVelibStation *userVelibStation = [[TCRouteClient sharedInstance] nearestVelibStationFrom:self.mapView.userLocation.location];
			TCTransportAnnotation* annotation = [[TCTransportAnnotation alloc] initWithTransport:self.currentTransport name:userVelibStation.name address:userVelibStation.address coordinate:userVelibStation.location.coordinate];
			[self.mapView addAnnotation:annotation];
			
			TCVelibStation *activityVelibStation = [[TCRouteClient sharedInstance] nearestVelibStationFrom:self.activityLocation];
			annotation = [[TCTransportAnnotation alloc] initWithTransport:self.currentTransport name:activityVelibStation.name address:activityVelibStation.address coordinate:activityVelibStation.location.coordinate];
			[self.mapView addAnnotation:annotation];
			
			[[TCRouteClient sharedInstance] findRouteFrom:userVelibStation.location.coordinate
													   to:activityVelibStation.location.coordinate
												transport:TCRouteTransportVelib
											   completion:^(BOOL success, TCRoute *route, NSError *error) {
												   [self.routes addObject:route];
												   [self.mapView addOverlay:route.polyline];
											   }];
		} break;
		case TCRouteTransportRATP: {
			BOOL p = YES;
            for (id<MKAnnotation> annotation in self.mapView.annotations) {
                NSLog(@"Lat: %f / Lon: %f",[annotation coordinate].latitude,[annotation coordinate].longitude);
            }            
		} break;
		case TCRouteTransportAutolib: {
			TCAutolibStation *userAutolibStation = [[TCRouteClient sharedInstance] nearestAutolibStationFrom:self.mapView.userLocation.location];
			TCTransportAnnotation* annotation = [[TCTransportAnnotation alloc] initWithTransport:self.currentTransport name:nil address:nil coordinate:userAutolibStation.location.coordinate];
			[self.mapView addAnnotation:annotation];
			
			TCAutolibStation *activityAutolibStation = [[TCRouteClient sharedInstance] nearestAutolibStationFrom:self.activityLocation];
			annotation = [[TCTransportAnnotation alloc] initWithTransport:self.currentTransport name:nil address:nil coordinate:activityAutolibStation.location.coordinate];
			[self.mapView addAnnotation:annotation];
			
			[[TCRouteClient sharedInstance] findRouteFrom:self.mapView.userLocation.coordinate
													   to:userAutolibStation.location.coordinate
												transport:TCRouteTransportWalk
											   completion:^(BOOL success, TCRoute *route, NSError *error) {
												   [self.routes addObject:route];
												   [self.mapView addOverlay:route.polyline];
											   }];
			
		} break;
	}
}

#pragma mark Route Types Selection
- (IBAction)switchCurrentTransport:(UIButton *)sender {
	[self setCurrentButton:sender];
}
- (void)setCurrentButton:(UIButton *)currentButton {
	if (![_currentButton isEqual:currentButton]) {
		if (_currentButton) {
			[_currentButton setSelected:NO];
		}
		_currentButton = currentButton;
		[_currentButton setSelected:YES];
		[UIView animateWithDuration:0.2
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState
						 animations:^{
							 [self.routeTransportArrow setCenter:_currentButton.center];
						 }
						 completion:^(BOOL finished) {}];
		[self reloadData];
	}
}
- (TCRouteTransport)currentTransport {
	if ([self.currentButton isEqual:self.autolibButton]) {
		return TCRouteTransportAutolib;
	}
	else if ([self.currentButton isEqual:self.velibButton]) {
		return TCRouteTransportVelib;
	}
	else if ([self.currentButton isEqual:self.ratpButton]) {
		return TCRouteTransportRATP;
	}
	else { //if ([self.currentButton isEqual:self.autolibButton]) {
		return TCRouteTransportWalk;
	}
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	CLLocation *userLocation = [locations lastObject];
	
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
		switch ([self routeForOverlay:overlay].transport) {
			case TCRouteTransportWalk:
				self.polylineView.lineDashPattern = @[@10.0,@10.0];
				break;
			case TCRouteTransportVelib:
				break;
			default:
				break;
		}
		self.polylineView.lineWidth = 3.0;
		self.polylineView.strokeColor = [UIColor tcBlack];
		self.polylineView.lineCap = kCGLineCapRound;
		self.polylineView.lineJoin = kCGLineJoinRound;
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
            locationAnnotationView.style = TCActivityColorStyleMusique;
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
