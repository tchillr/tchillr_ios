//
//  TCActivityDetailViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivityDetailViewController.h"

@interface TCActivityDetailViewController ()

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
