//
//  TCVelibStation.h
//  Tchillr
//
//  Created by Zouhair on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

// Frameworks
#import <MapKit/MapKit.h>

@interface TCVelibStation : TCObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSNumber *number;
@property (strong, nonatomic) NSString *availability;
@property (nonatomic, readonly) CLLocation *location;

@end
