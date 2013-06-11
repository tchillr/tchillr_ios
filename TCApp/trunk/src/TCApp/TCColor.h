//
//  TCColor.h
//  TCApp
//
//  Created by Jad on 11/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCColor : NSObject

@property (nonatomic, retain) UIColor * backgroundColor;
@property (nonatomic, retain) UIColor * titleColor;

- (id) initWithBackgroundColor:(UIColor *) backgroundColor andTitleColor:(UIColor *) titleColor;

@end
