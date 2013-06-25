//
//  TCMapViewController.h
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TCViewController.h"
#import "TCCalloutAnnotationView.h"

@interface TCMapViewController : TCViewController<UICollectionViewDelegate, MKMapViewDelegate, TCCalloutAnnotationViewDelegate>

@end
