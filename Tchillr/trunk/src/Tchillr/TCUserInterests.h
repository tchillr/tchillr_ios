//
//  TCUserInterest.h
//  Tchillr
//
//  Created by Jad on 08/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCUserInterests : NSObject

@property (nonatomic, retain) NSArray * interests;

+ (TCUserInterests *)sharedTchillrUserInterests;

@end
