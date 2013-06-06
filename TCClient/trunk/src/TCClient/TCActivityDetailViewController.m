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
    [self.nameLabel setText:self.activity.name];
    [self.descriptionLabel setText:self.activity.description];
}

@end
