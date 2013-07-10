//
//  TCLocationAnnotationView.h
//  Tchillr
//
//  Created by Jad on 21/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "UIColor+Tchillr.h"

typedef enum{
    TCLocationAnnotationViewSizeTypeNone,
    TCLocationAnnotationViewSizeTypeSmall,
    TCLocationAnnotationViewSizeTypeMedium,
    TCLocationAnnotationViewSizeTypeLarge
}TCLocationAnnotationViewSizeType;

@interface TCLocationAnnotationView : MKAnnotationView

@property (nonatomic, assign) TCActivityColorStyle style;
@property (nonatomic, assign) TCLocationAnnotationViewSizeType sizeType;

#pragma mark Lifecycle
- (id)initWithAnnotation:(id <MKAnnotation>) annotation reuseIdentifier:(NSString *) reuseIdentifier andSize:(TCLocationAnnotationViewSizeType)sizeType;

@end
