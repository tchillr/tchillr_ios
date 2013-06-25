//
//  TCLocationAnnotationView.h
//  Tchillr
//
//  Created by Jad on 21/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "UIColor+Tchillr.h"

@interface TCLocationAnnotationView : MKAnnotationView

@property (nonatomic, assign) TCColorStyle style;

@end
