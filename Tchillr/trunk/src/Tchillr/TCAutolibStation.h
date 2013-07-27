//
//  TCAutolibStation.h
//  Tchillr
//
//  Created by Zouhair on 08/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

// Frameworks
#import <MapKit/MapKit.h>

@interface TCAutolibStation : TCObject

@property (strong, nonatomic) NSString *availability;
@property (nonatomic, readonly) CLLocation *location;

@end
