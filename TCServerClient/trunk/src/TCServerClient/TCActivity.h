//
//  TCActivity.h
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"
@class TCTag;
@class TCMedia;
@interface TCActivity : TCObject

@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSString *shortDescription;
@property (nonatomic, readonly) NSArray  *occurences;
@property (nonatomic, readonly) NSString *city;
@property (nonatomic, readonly) NSString *place;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) CGFloat longitude;
@property (nonatomic, readonly) CGFloat latitude;
@property (nonatomic, readonly) NSString *zipcode;
@property (nonatomic, readonly) NSArray *keywords;
@property (nonatomic, readonly) NSArray *tags;

@property (nonatomic, readonly) NSString *accessType;
@property (nonatomic, readonly) BOOL hasFee;
@property (nonatomic, readonly) NSNumber *price;
@property (nonatomic, readonly) NSNumber *score;
@property (nonatomic, readonly) NSArray *medias;

#pragma mark Formatted Day
- (NSString *) formattedDay;
#pragma mark Formatted Time
- (NSString *) formattedTime;
#pragma mark Address formatting
- (NSString *)fullAddress;
#pragma mark Formatted Access Type / Price
- (NSString*) formattedAccessTypeAndPrice;
#pragma mark Tags
- (BOOL)hasTags;
- (TCTag *)tagAtIndex:(NSUInteger) index;
- (NSInteger)numberOfTags;
#pragma mark Formatted Tags
- (NSString *)formattedTags;
#pragma mark Medias access
- (TCMedia *)mediaAtIndex:(NSInteger)index;
- (NSInteger)numberOfMedias;

@end
