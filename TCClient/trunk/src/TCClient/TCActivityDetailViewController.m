//
//  TCActivityDetailViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivityDetailViewController.h"
//#import "TCInterestView.h"
#import "TCConstants.h"
#import <MapKit/MapKit.h>
//#import "TCAnnotationView.h"

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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityNameLabel setText:self.activity.name];
    [self.activityShortDescriptionLabel setText:self.activity.shortDescription];
    [self.activityDescriptionLabel setText:self.activity.description];
    [self.activityFullAdressLabel setText:self.activity.fullAdress];
    [self.activityNextOccurenceLabel setText:self.activity.formattedOccurence];
    [self.activityContextualTags setText:self.activity.formattedContextualTags];
}


@end
