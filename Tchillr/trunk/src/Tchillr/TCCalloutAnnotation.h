//
//  TCCalloutAnnotation.h
//  Tchillr
//
//  Created by Jad on 24/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface TCCalloutAnnotation : NSObject<MKAnnotation>

@property (nonatomic, retain) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end


