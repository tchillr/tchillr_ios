//
//  TCAnnotationView.h
//  Tchillr
//
//  Created by Jad on 18/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface TCAnnotationView : MKAnnotationView

@property (nonatomic,retain) UILabel *zipCode;
@property (nonatomic,retain) UILabel *adress;
@property (nonatomic,retain) UIImageView *backgroundImageView;
@property (nonatomic,retain) UILabel *title;

@end
