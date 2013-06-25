//
//  TCLocation.h
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TCCalloutAnnotation.h"

@interface TCLocationAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, retain) TCCalloutAnnotation *calloutAnnotation;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
