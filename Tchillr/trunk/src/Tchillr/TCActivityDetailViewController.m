//
//  TCActivityDetailViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivityDetailViewController.h"
#import "TCConstants.h"
#import <MapKit/MapKit.h>
#import "TCTriangleView.h"
#import "UIColor+Tchillr.h"

@interface TCActivityDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityShortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityFullAddressLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *activityTagsView;
@property (weak, nonatomic) IBOutlet UILabel *activityNextOccurenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityContextualTags;

@property (nonatomic, retain) IBOutlet UIButton * backButton;
@property (nonatomic, retain) IBOutlet TCTriangleView * triangleView;

@end

@implementation TCActivityDetailViewController


#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityNameLabel setText:self.activity.name];
    [self.activityShortDescriptionLabel setText:self.activity.shortDescription];
    [self.activityDescriptionLabel setText:self.activity.description];
    [self.activityFullAddressLabel setText:self.activity.fullAddress];
    [self.activityNextOccurenceLabel setText:self.activity.formattedOccurence];
    [self.activityContextualTags setText:self.activity.formattedContextualTags];
    self.triangleView.style = TCColorStyleMusic;
}

#pragma mark Pop 
- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
