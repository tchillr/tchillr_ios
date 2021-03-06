//
//  TCActivityDetailViewController.h
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCActivity.h"
//#import "TCInterestView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TCActivityDetailViewController : UIViewController< MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) TCActivity * activity;

@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityShortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityFullAdressLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *activityTagsView;
@property (weak, nonatomic) IBOutlet UILabel *activityNextOccurenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityContextualTags;

@end
