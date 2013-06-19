//
//  TCActivityDetailViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivityDetailViewController.h"
#import "TCInterestView.h"
#import "TCConstants.h"
#import <MapKit/MapKit.h>
#import "TCAnnotationView.h"

@interface TCActivityDetailViewController ()

@property (nonatomic, retain) IBOutlet UIView * contentView;
@property (nonatomic, retain) IBOutlet UIView * headerView;
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UIButton * goingButton;
// Map
@property (nonatomic, retain) IBOutlet MKMapView * mapView;
@property(nonatomic,retain) CLLocation *currentLocation;
@property(nonatomic,retain) NSMutableArray *annotations;
@property(nonatomic,retain) CLLocationManager *location;
@end

@implementation TCActivityDetailViewController

@synthesize location = _location;
- (CLLocationManager *)location{
    if (_location == nil) {
        _location = [[CLLocationManager alloc] init];
    }
    return _location;
}

@synthesize annotations = _annotations;
- (NSMutableArray *)annotations {
    if (_annotations == nil) {
        _annotations = [[NSMutableArray alloc]init];
    }
    return _annotations;
}

- (void)setupInterestViews {
    CGRect contentViewFrame = self.contentView.frame;
    CGFloat yOffset = contentViewFrame.size.height + kInterestViewHeight;
    
    for (int i = 0; i < [self.activity numberOfTags]; i++) {
        TCInterestView * interestView = [[TCInterestView alloc] initWithFrame:CGRectMake(0.0, yOffset, self.view.frame.size.width, kInterestViewHeight) andTitle:[self.activity tagAtIndex:i]];
        [interestView setDelegate:self];
        [self.scrollView addSubview:interestView];
        yOffset += kInterestViewHeight + kInterestViewSpacing;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityNameLabel setText:self.activity.name];
    [self.activityShortDescriptionLabel setText:self.activity.shortDescription];
    [self.activityDescriptionLabel setText:self.activity.description];
    [self.activityFullAdressLabel setText:self.activity.fullAdress];
    [self.activityNextOccurenceLabel setText:self.activity.formattedOccurence];
    [self.activityContextualTags setText:self.activity.formattedContextualTags];
    [self setupInterestViews];
    [self.mapView setFrame:CGRectMake(0.0, [self yOffsetForMap], self.view.frame.size.width, kMapViewHeight)];
    [self.goingButton setFrame:CGRectMake(0, [self yOffsetForGoingButton], self.view.frame.size.width, self.goingButton.frame.size.height)];
    [self.scrollView setContentSize:[self contentSizeForScrollView]];
    NSLog(@"ScrollView content size : %@",NSStringFromCGSize(self.scrollView.contentSize));
    
    // Map setup
    self.annotations = [NSMutableArray array];
    [self.mapView setShowsUserLocation:YES];
    [self.location setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [self.location setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
}
#pragma mark - TCInterestViewDelegate methods
- (void) userDidTapInterestView:(TCInterestView *)interestView atIndex:(NSInteger)index{
    //TCActivity * activity = [self.activity tagAtIndex:index];
    
}

#pragma mark User action
#warning call the webservice to subscribe user to the current activity
- (IBAction) goingButtonClicked:(UIButton *)sender {
    
}


#pragma mark - ScrollView content size computation
#warning Checker avec Zouhair pourquoi +88 / resizing mask ?
- (CGSize) contentSizeForScrollView {
    return CGSizeMake(self.view.frame.size.width, self.goingButton.frame.origin.y + self.goingButton.frame.size.height + 88);
}

- (CGFloat) yOffsetForMap {
    return [self headerViewHeight] + [self contentViewHeight] + [self tagsViewHeight];
}

- (CGFloat) yOffsetForGoingButton {
    return [self yOffsetForMap] + self.mapView.frame.size.height + kInterestViewSpacing;
}
    
- (CGFloat) headerViewHeight {
    return self.headerView.frame.size.height;
}

- (CGFloat) contentViewHeight {
    return self.contentView.frame.size.height;
}

- (CGFloat) tagsViewHeight {
    return [self.activity numberOfTags] * (kInterestViewHeight + kInterestViewSpacing);
}

- (CGFloat) mapViewHeight {
    return self.mapView.frame.size.height;
}

#pragma mark - MKMapViewDelegate

#pragma mark - MapView Delegate
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
	if([annotation isKindOfClass:[MKUserLocation class]])
	{
        [mapView viewForAnnotation:annotation].canShowCallout = NO;
        return [mapView viewForAnnotation:annotation];
	}
	
	TCAnnotationView *pin = (TCAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"currentloc"];
    
	if (pin == nil){
		pin = [[TCAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	}
    
    [pin setAnnotation:annotation];
    [pin.title setText:self.activity.name];
    [pin.adress setText:self.activity.adress];
    [pin.zipCode setText:self.activity.zipcode];
    [pin.backgroundImageView setImage:[UIImage imageNamed:@""]];
	
    pin.canShowCallout = NO;
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    MKCoordinateRegion region = mapView.region;
    region.center = view.annotation.coordinate;
    [self.mapView setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for(int i = 0; i< [views count]; i++)
    {
        if([[[[views objectAtIndex:i] class] description] isEqualToString:@"MKUserLocationView"])
        {
            ((MKAnnotationView*)[views objectAtIndex:i]).canShowCallout = NO;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    
    self.currentLocation = newLocation;
    
    MKCoordinateRegion region;
    region.center = self.currentLocation.coordinate;
    
    MKCoordinateSpan span;
    span.latitudeDelta  = 0.02;
    span.longitudeDelta = 0.02;
    region.span = span;
    
    [self.mapView setRegion:region animated:YES];
    
   // [[LTFdjAPIClient sharedInstance] getPDV:URLPDV(self.currentLocation.coordinate.latitude,self.currentLocation.coordinate.longitude)];
}


#pragma mark - PDV methods
- (void)getPDVSucceeded:(NSNotification *)notification {
	NSArray *pdvDatas = (NSArray *)[notification userInfo];
    
	if (pdvDatas && [pdvDatas count] > 0) {
        NSEnumerator *pdvs = [pdvDatas objectEnumerator];
        NSDictionary *pdv;
        
        NSMutableArray *newAnnotations = [NSMutableArray array];
        
        while(pdv = [pdvs nextObject])
        {
            TCAnnotationView *annotation = [[TCAnnotationView alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.activity.latitude, self.activity.longitude)];
            
            if(![[pdv objectForKey:@"ENSEIGNE"] isKindOfClass:[NSNull class]])
                [annotation setName:[pdv objectForKey:@"ENSEIGNE"]];
            else
                [annotation setName:@"Point de vente FDJ"];
            
            if(![[pdv objectForKey:@"ADRESSE"] isKindOfClass:[NSNull class]])
                [annotation setAdresse:[pdv objectForKey:@"ADRESSE"]];
            
            if(![[pdv objectForKey:@"ID"] isKindOfClass:[NSNull class]])
                [annotation setPdvId:[pdv objectForKey:@"ID"]];
            
            if(![[pdv objectForKey:@"VILLE"] isKindOfClass:[NSNull class]])
                [annotation setVille:[pdv objectForKey:@"VILLE"]];
            
            BOOL exists = NO;
            
            for(int i = 0; i < self.annotations.count; i++)
            {
                LTPDVAnnotation *annot = [self.annotations objectAtIndex:i];
                if([[annot pdvId] isEqualToString:annotation.pdvId])
                {
                    exists = YES;
                }
            }
            
            if(!exists)
                [newAnnotations addObject:annotation];
            [annotation release];
        }
	    
        if(newAnnotations.count > 0)
        {
            [map removeAnnotations:annotations];
            [self.annotations addObjectsFromArray:newAnnotations];
            [map addAnnotations:self.annotations];
        }
	}
}



@end
