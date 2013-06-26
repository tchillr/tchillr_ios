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

// Views & Controls
#import "TCLocationAnnotationView.h"
#import "TCCalloutAnnotationView.h"
#import "TCActivityCollectionViewCell.h"

// Model
#import "TCServerClient.h"
#import "TCActivity.h"
#import "TCLocationAnnotation.h"
#import "TCCalloutAnnotation.h"

#define METERS_FOR_DISTANCE 1250

@interface TCMapViewController () <UICollectionViewDelegate, MKMapViewDelegate, TCCalloutAnnotationViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView * mapView;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, weak) IBOutlet UIButton * showInterestsButton;
@property (nonatomic, weak) IBOutlet UIButton * showListButton;
@property (nonatomic, retain) NSArray * activities;

@end

@implementation TCMapViewController

@synthesize mapView = _mapView;
@synthesize activities = _activities;
@synthesize collectionView = _collectionView;
@synthesize showInterestsButton = _showInterestsButton;
@synthesize showListButton = _showListButton;

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView setAlpha:0];
    [self.showListButton setAlpha:0];
    [[TCServerClient sharedTchillrServerClient]
	 startUserActivitiesRequestForDays:10
	 success:^(NSArray *activitiesArray) {
		 self.activities = activitiesArray;
		 [self pinLocations];
		 TCLocationAnnotation * annotation = [self annotationForIndex:0];
		 [self.mapView selectAnnotation:annotation animated:NO];
		 [self.collectionView reloadData];
		 [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
			 [self.collectionView setAlpha:0.8];
			 [self.showListButton setAlpha:0.8];
		 } completion:^(BOOL finished) {
		 }];
	 }
	 failure:^(NSError *error) {
		 NSLog(@"%@",[error description]);
	 }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView setShowsUserLocation:YES];
}

#pragma mark - Pin locations
- (void) pinLocations{
    for (int i = 0; i < [self numberOfActivities]; i++) {
        TCActivity * activity = [self activityAtIndex:i];
        TCLocationAnnotation* annotation = [[TCLocationAnnotation alloc] initWithName:activity.name address:activity.fullAddress coordinate:CLLocationCoordinate2DMake(activity.latitude,activity.longitude)];
        annotation.index = i;
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	id annotationView = nil;
	if ([annotation isMemberOfClass:[TCLocationAnnotation class]]) {
        TCLocationAnnotationView *locationAnnotationView = (TCLocationAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TCLocationAnnotation class])];
        if (locationAnnotationView == nil) {
            locationAnnotationView = [[TCLocationAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TCLocationAnnotationView class])];
            locationAnnotationView.style = TCColorStyleMusic;
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
        calloutAnnotationView.delegate = self;
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
	cell.activityShortDescriptionLabel.text = activity.shortDescription;
	cell.activityTagsLabel.text = activity.formattedTags;
	
    return cell;
}

#define kShowActivityDetailSegueIdentifier @"ShowActivityDetailSegue"

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
}

#pragma mark TCCalloutAnnotationViewDelegate methods
- (void) calloutAnnotationButtonClicked {
	[self performSegueWithIdentifier:kShowActivityDetailSegueIdentifier sender:nil];
}

@end
