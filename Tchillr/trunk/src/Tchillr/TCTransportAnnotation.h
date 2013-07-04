//
//  TCTransportAnnoation.h
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
#import <MapKit/MapKit.h>

// Model
#import "TCRouteClient.h"

@interface TCTransportAnnotation : NSObject <MKAnnotation>

@property (assign, nonatomic, readonly) TCRouteTransport transport;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *address;

- (id)initWithTransport:(TCRouteTransport)transport name:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
