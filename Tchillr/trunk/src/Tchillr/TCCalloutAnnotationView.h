//
//  TCCalloutAnnotationView.h
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol TCCalloutAnnotationViewDelegate <NSObject>

#pragma mark TCCalloutAnnotationViewDelegate methods
- (void) calloutAnnotationButtonClicked;

@end

@interface TCCalloutAnnotationView : MKAnnotationView

@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) id<TCCalloutAnnotationViewDelegate> delegate;

@end



