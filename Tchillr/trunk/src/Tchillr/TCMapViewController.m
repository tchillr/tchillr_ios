//
//  TCMapViewController.m
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCMapViewController.h"

// Frameworks
#import <MapKit/MapKit.h>

// Controllers
#import "TCActivityDetailViewController.h"
#import "TCTastesViewController.h"

// Views & Controls
#import "TCLocationAnnotationView.h"
#import "TCCalloutAnnotationView.h"
#import "TCActivityCollectionViewCell.h"

// Categories
#import "NSString+TCAdditions.h"

// Model
#import "TCServerClient.h"
#import "TCActivity.h"
#import "TCLocationAnnotation.h"
#import "TCCalloutAnnotation.h"
#import "TCAppDelegate.h"
#import "TCUserInterests.h"
#import "TCUserAttendance.h"

#define kShowActivityDetailSegueIdentifier @"ShowActivityDetailSegue"
#define kshowTastesSegueIdentifier @"ShowTastesSegue"

#define METERS_FOR_DISTANCE 1250

@interface TCMapViewController () <UICollectionViewDelegate, MKMapViewDelegate, TCTastesViewControllerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView * mapView;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, weak) IBOutlet UIButton * showInterestsButton;
@property (nonatomic, weak) IBOutlet UIButton * showListButton;
@property (nonatomic, weak) IBOutlet UIView * loadingView;
@property (nonatomic, weak) IBOutlet UILabel * statusLabel;
@property (nonatomic, retain) NSArray * activities;
@property (nonatomic, retain) CLLocationManager * locationManager;
@property (nonatomic, assign) BOOL shouldReloadData;

@end

@implementation TCMapViewController

@synthesize mapView = _mapView;
@synthesize activities = _activities;
@synthesize collectionView = _collectionView;
@synthesize showInterestsButton = _showInterestsButton;
@synthesize showListButton = _showListButton;
@synthesize statusLabel = _statusLabel;

- (void)reloadDataNeeded {
    self.shouldReloadData = YES;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];    
    self.shouldReloadData = YES;
    [self.mapView setShowsUserLocation:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataNeeded) name:kTCUserInterestsChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    // Load the user interests
    [[TCServerClient sharedTchillrServerClient] startInterestsRequestWithSuccess:^(NSArray *interestsArray) {
        [TCUserInterests sharedTchillrUserInterests].interests = interestsArray;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTCUserInterestsChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.shouldReloadData) {
        [self reloadData];
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    self.shouldReloadData = YES;
}

#pragma mark - Pin locations
- (void) pinLocations{
    for (int i = 0; i < [self numberOfActivities]; i++) {
        TCActivity * activity = [self activityAtIndex:i];
        TCLocationAnnotation* annotation = [[TCLocationAnnotation alloc] initWithName:activity.name address:activity.fullAddress coordinate:CLLocationCoordinate2DMake(activity.latitude,activity.longitude)];
        annotation.index = i;
        BOOL valid = [annotation coordinateIsValid];
        if (valid) {
            [self.mapView addAnnotation:annotation];
        }
        else {
            NSLog(@"Invalid coordinates for annotation %@",annotation.title);
        }    
    }
}

#pragma mark TCLocationAnnotationViewSizeType from Activity at Index
- (TCLocationAnnotationViewSizeType) annotationSizeTypeForActivityAtIndex:(NSInteger)index {
    TCLocationAnnotationViewSizeType sizeType;
    TCActivity * activity = [self activityAtIndex:index];
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

#pragma mark MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	id annotationView = nil;
	if ([annotation isMemberOfClass:[TCLocationAnnotation class]]) {
        TCLocationAnnotationView *locationAnnotationView = (TCLocationAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TCLocationAnnotation class])];
        if (locationAnnotationView == nil) {
            locationAnnotationView = [[TCLocationAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TCLocationAnnotationView class]) andSize:[self annotationSizeTypeForActivityAtIndex:((TCLocationAnnotation*)annotation).index]];
            TCActivity * activity = [self activityAtIndex:((TCLocationAnnotation*)annotation).index];
            locationAnnotationView.style = activity.colorStyle;
            locationAnnotationView.enabled = YES;
            locationAnnotationView.canShowCallout = NO;
        }
		else {
            locationAnnotationView.annotation = annotation;
        }
		annotationView = locationAnnotationView;
    }
    else if ([annotation isMemberOfClass:[TCCalloutAnnotation class]]) {
        TCCalloutAnnotationView *calloutAnnotationView = (TCCalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TCCalloutAnnotation class])];
        
        if (!calloutAnnotationView) {
            calloutAnnotationView = [[TCCalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TCCalloutAnnotation class])];
        }
        TCCalloutAnnotation *calloutAnnotation = (TCCalloutAnnotation *)annotation;
        
        calloutAnnotationView.title = calloutAnnotation.title;
		[calloutAnnotationView setNeedsLayout];
		
		annotationView = calloutAnnotationView;
    }
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[TCLocationAnnotation class]]) {
        TCCalloutAnnotation *calloutAnnotation = [[TCCalloutAnnotation alloc] init];
        TCLocationAnnotation *annotation = ((TCLocationAnnotation *)view.annotation);
        calloutAnnotation.title      = annotation.title;
        calloutAnnotation.coordinate = annotation.coordinate;
        annotation.calloutAnnotation = calloutAnnotation;
        [mapView addAnnotation:calloutAnnotation];
        [self.collectionView scrollRectToVisible:CGRectMake(annotation.index * self.collectionView.bounds.size.width, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height) animated:YES];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, METERS_FOR_DISTANCE, METERS_FOR_DISTANCE);
        [mapView setRegion:region animated:YES];
    }
    else if ([view isKindOfClass:[TCCalloutAnnotationView class]]) {
        [self performSegueWithIdentifier:kShowActivityDetailSegueIdentifier sender:nil];
    }
    [self distanceToAnnotation:view.annotation];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[TCLocationAnnotation class]]) {
        TCLocationAnnotation *annotation = ((TCLocationAnnotation *)view.annotation);
        [mapView removeAnnotation:annotation.calloutAnnotation];
        annotation.calloutAnnotation = nil;
    }
}

- (id <MKAnnotation>) annotationForIndex:(NSInteger)index {
    NSUInteger i = [self.mapView.annotations indexOfObjectPassingTest:^BOOL(id<MKAnnotation>  annotation, NSUInteger idx, BOOL *stop) {
        return [annotation isKindOfClass:[TCLocationAnnotation class]] && ((TCLocationAnnotation*)annotation).index == index;
    }];
    return (i != NSNotFound) ? [self.mapView.annotations objectAtIndex:i] : nil ;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    TCLocationAnnotation * annotation = [self annotationForIndex:index];    
    [self.mapView selectAnnotation:annotation animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self distanceToAnnotation:[mapView.selectedAnnotations objectAtIndex:0]];
}

#pragma mark Activities access
- (TCActivity *) activityAtIndex:(NSInteger)index {
    return [self.activities objectAtIndex:index];
}

- (NSInteger)numberOfActivities {
    return [self.activities count];
}

- (TCActivity *) currentActivity {
    NSUInteger index = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    return [self activityAtIndex:index];
}

#pragma mark UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfActivities];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TCActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCActivityCollectionViewCell class]) forIndexPath:indexPath];
    TCActivity * activity = [self activityAtIndex:indexPath.row];
	cell.activityDayLabel.text = activity.formattedDay;
	cell.activityTimeLabel.text = activity.formattedTime;
	cell.activityTimeLabel.text = activity.formattedTime;
    cell.activityShortDescriptionLabel.text = ([activity.shortDescription isEmpty]) ? activity.name : activity.shortDescription;
	cell.activityTagsLabel.text = activity.formattedTags;
    cell.activityDistanceLabel.text = [self distanceToAnnotation:[self annotationForIndex:indexPath.row]];
    return cell;
}

#pragma mark Prepare segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kShowActivityDetailSegueIdentifier]) {
		TCActivity * activity = nil;
		if (sender) {
			TCActivityCollectionViewCell * cellTouched = (TCActivityCollectionViewCell *)sender;
			NSIndexPath * indexPath = [self.collectionView indexPathForCell:cellTouched];
			activity = [self activityAtIndex:indexPath.row];
		}
		else {
			activity = [self currentActivity];
		}
		TCActivityDetailViewController * activityDetailViewController = (TCActivityDetailViewController *) segue.destinationViewController;
		[activityDetailViewController setActivity:activity];
	}
	else if ([segue.identifier isEqualToString:kshowTastesSegueIdentifier]) {
		[segue.destinationViewController setDelegate:self];
	}
}

#pragma mark TCTastesViewControllerDelegate
- (void)tastesViewControllerDidFinishEditing:(TCTastesViewController *)tastesViewController{
	[self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)reloadData {
    [self.loadingView setAlpha:1];
    [self.collectionView setAlpha:0];
    // Remove all annotations except the user location annotation
    NSMutableArray * annotationsToRemove = [NSMutableArray array];
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if (![annotation isKindOfClass:[MKUserLocation class]]) {
            [annotationsToRemove addObject:annotation];
        }        
    }
    [self.mapView removeAnnotations:annotationsToRemove];
    
    // Reload map annotations
    NSDate * now = [NSDate date];
    NSDate *tomorrow = [now dateByAddingTimeInterval:60*60*24*1];
    
    [[TCServerClient sharedTchillrServerClient] startUserActivitiesRequestFrom:now to:tomorrow success:^(NSArray *activitiesArray) {
        self.activities = activitiesArray;
        if ([self.activities count] == 0) {
            [self.statusLabel setText:@"Aucun résultat"];
        }
        else {
            [self pinLocations];
            TCLocationAnnotation * annotation = [self annotationForIndex:0];
            [self.mapView selectAnnotation:annotation animated:NO];
            [self.collectionView reloadData];
            self.shouldReloadData = NO;
            [UIView animateWithDuration:0.2
                             animations:^{
                                 [self.loadingView setAlpha:0.0];
                                 [self.collectionView setAlpha:1];
                                 [self.mapView setShowsUserLocation:YES];
                                 
                             }];
        }
    } failure:^(NSError *error) {
        NSLog(@"Error in startUserActivitiesRequestFrom :%@",[error description]);
        self.shouldReloadData = NO;
    }];    
}

#pragma mark
- (NSString *)distanceToAnnotation:(id<MKAnnotation>)annotation {
    CLLocation *pinLocation = [[CLLocation alloc]
                               initWithLatitude:annotation.coordinate.latitude
                               longitude:annotation.coordinate.longitude];
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:self.mapView.userLocation.coordinate.latitude
                                longitude:self.mapView.userLocation.coordinate.longitude];
    CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    NSString * distanceToAnnotation = nil;
    if (distance > 1000) {
        distanceToAnnotation = [NSString stringWithFormat:@"%.2f km", distance / 1000];
    }
    else {
        distanceToAnnotation = [NSString stringWithFormat:@"%4.0f m", distance];

    }
    return distanceToAnnotation;
}

@end
