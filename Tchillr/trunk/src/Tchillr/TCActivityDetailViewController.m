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

@interface TCActivityDetailViewController ()

@property (nonatomic, retain) IBOutlet UIView * contentView;
@property (nonatomic, retain) IBOutlet UIView * headerView;
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UIButton * goingButton;
@property (nonatomic, retain) IBOutlet UIButton * backButton;


@end

@implementation TCActivityDetailViewController

#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityNameLabel setText:self.activity.name];
    [self.activityShortDescriptionLabel setText:self.activity.shortDescription];
    [self.activityDescriptionLabel setText:self.activity.description];
    [self.activityFullAdressLabel setText:self.activity.fullAdress];
    [self.activityNextOccurenceLabel setText:self.activity.formattedOccurence];
    [self.activityContextualTags setText:self.activity.formattedContextualTags];
}

#pragma mark Pop 
- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
