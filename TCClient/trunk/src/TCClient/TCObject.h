//
//  TCObject.h
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCObject : NSObject

#pragma mark Properties
@property (nonatomic, retain) NSDictionary *jsonDictionary;

/** @name Initializer */
#pragma mark Initializer
- (id)initWithJsonDictionary:(NSDictionary *)jsonDictionary;

/** @name Static Initializer */
#pragma mark Static Initializer
+ (id)objectWithJsonDictionary:(NSDictionary *)jsonDictionary;

@end
