//
//  TCActivity.h
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

@interface TCActivity : TCObject

@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSString *shortDescription;
@property (nonatomic, readonly) NSArray  *occurences;
@property (nonatomic, readonly) NSString *city;
@property (nonatomic, readonly) NSString *place;
@property (nonatomic, readonly) NSString *adress;
@property (nonatomic, readonly) NSString *longitude;
@property (nonatomic, readonly) NSString *latitude;
@property (nonatomic, readonly) NSString *zipcode;
@property (nonatomic, readonly) NSArray *keywords;

#pragma mark Adress formatting
- (NSString *)fullAdress;

@end
