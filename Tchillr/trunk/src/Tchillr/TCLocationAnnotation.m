//
//  TCLocation.m
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCLocationAnnotation.h"
#import <MapKit/MapKit.h>

@interface TCLocationAnnotation ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation TCLocationAnnotation

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        self.name = name;
        self.address = address;
        self.coordinate = coordinate;
        self.index = NSNotFound;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}

- (NSUInteger)index {
    return _index;
}

@end