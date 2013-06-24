//
//  TCMapViewController.m
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCMapViewController.h"
#import "TCLocationAnnotation.h"
#import <MapKit/MapKit.h>
#import "TCTchillrServerClient.h"
#import "TCActivity.h"
#import "TCActivityCollectionViewCell.h"
#import "TCActivityDetailViewController.h"
#import "TCLocationAnnotationView.h"

#define kCircleImage [UIImage imageNamed:@"circle"]

#define METERS_FOR_DISTANCE 1250

@interface TCMapViewController ()

@property (nonatomic, weak) IBOutlet MKMapView * mapView;
@property (nonatomic, retain) IBOutlet UICollectionView * collectionView;
@property (nonatomic, retain) IBOutlet UIButton * showInterestsButton;
@property (nonatomic, retain) IBOutlet UIButton * showListButton;
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
	[[TCTchillrServerClient sharedTchillrServerClient] startUserActivitiesRequestWithSuccess:^(NSArray *activitiesArray) {
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
        
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    } offset:0 limit:3000];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CLLocationCoordinate2D zoomLocation;
    // Guy Môquet (in the place to be !)
    zoomLocation.latitude = 48.8928290;
    zoomLocation.longitude= 2.3272670;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_FOR_DISTANCE, METERS_FOR_DISTANCE);
    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView setShowsUserLocation:YES];
}

#pragma mark - Pin locations
- (void) pinLocations{
    // Guy Môquet (in the place to be !)
    CLLocationCoordinate2D guyMoquet = CLLocationCoordinate2DMake(48.8928290,2.3272670);    
    for (int i = 0; i < [self.activities count]; i++) {
        TCActivity * activity = [self activityAtIndex:i];
        CGFloat latDelta = rand()*.035/RAND_MAX -.02;
        CGFloat longDelta = rand()*.03/RAND_MAX -.015;
        
        /*
        CGFloat latDelta = activity.latitude;
        CGFloat longDelta = activity.longitude;
        */
        CLLocationCoordinate2D newCoord = {guyMoquet.latitude+latDelta, guyMoquet.longitude+longDelta};
        TCLocationAnnotation* annotation = [[TCLocationAnnotation alloc] initWithName:activity.name address:activity.fullAdress coordinate:newCoord];
        annotation.index = i;
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark MKMapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {

    if ([annotation isKindOfClass:[TCLocationAnnotation class]]) {
        NSLog(@"Annotation %@ at index %i",[annotation description],((TCLocationAnnotation *)annotation).index);
        TCLocationAnnotationView *annotationView = (TCLocationAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TCLocationAnnotation class])];
        if (annotationView == nil) {
            annotationView = [[TCLocationAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TCLocationAnnotationView class])];
            annotationView.style = TCColorsStyleMusic;
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    TCLocationAnnotation * annotation = view.annotation;
    NSLog(@"Annotation is at index %i",annotation.index);
    [self.collectionView scrollRectToVisible:CGRectMake(annotation.index * self.collectionView.bounds.size.width, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height) animated:YES];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, METERS_FOR_DISTANCE, METERS_FOR_DISTANCE);
    [self.mapView setRegion:region animated:YES];
}

- (id <MKAnnotation>) annotationForIndex:(NSInteger)index {
    NSUInteger i = [self.mapView.annotations indexOfObjectPassingTest:^BOOL(TCLocationAnnotation * annotation, NSUInteger idx, BOOL *stop) {
        return annotation.index == index;
    }];
    return (i != NSNotFound) ? [self.mapView.annotations objectAtIndex:i] : nil ;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSLog(@"scrollViewDidEndDecelerating at index : %i",index);
    TCLocationAnnotation * annotation = [self annotationForIndex:index];    
    [self.mapView selectAnnotation:annotation animated:NO];
}

#pragma mark Activities access
- (TCActivity *) activityAtIndex:(NSInteger)index {
    return (TCActivity *)[self.activities objectAtIndex:index];
}

- (NSInteger)numberOfActivities {
    return [self.activities count];
}

#pragma mark UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfActivities];;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TCActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCActivityCollectionViewCell class]) forIndexPath:indexPath];
    TCActivity * activity = [self activityAtIndex:indexPath.row];
    if (cell) {
        cell.activityDayLabel.text = activity.formattedDay;
        cell.activityTimeLabel.text = activity.formattedTime;
        cell.activityTimeLabel.text = activity.formattedTime;
        cell.activityShortDescriptionLabel.text = activity.shortDescription;
        cell.activityHeartImageView.image = [UIImage imageNamed:@"heart"];
        cell.activityTagsLabel.text = activity.formattedContextualTags;
    }
    return cell;
}

#pragma mark Prepare segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TCActivityCollectionViewCell * cellTouched = (TCActivityCollectionViewCell *)sender;
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cellTouched];
    TCActivity * activity = [self activityAtIndex:indexPath.row];
    TCActivityDetailViewController * activityDetailViewController = (TCActivityDetailViewController *) segue.destinationViewController;
    [activityDetailViewController setActivity:activity];
}

@end
