//
//  TCColors.h
//  TCApp
//
//  Created by Jad on 11/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCColor;

@interface TCColors : NSObject

@property (nonatomic, retain) NSArray * colors;

+(TCColor*) colorAtIndex:(NSInteger)index;

@end
