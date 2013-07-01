//
//  TCRouteViewController.m
//  Tchillr
//
//  Created by Jad on 26/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCRouteViewController.h"

// Frameworks
#import <MapKit/MapKit.h>

// Model
#import "TCActivity.h"

@interface TCRouteViewController () <MKMapViewDelegate>

#pragma mark Map Management
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


#pragma mark Back Navigation
- (IBAction)popViewController:(id)sender;

@end

@implementation TCRouteViewController

#pragma mark View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Back Navigation
- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
