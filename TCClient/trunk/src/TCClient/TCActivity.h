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
@property (nonatomic, readonly) CGFloat longitude;
@property (nonatomic, readonly) CGFloat latitude;
@property (nonatomic, readonly) NSNumber *zipcode;
@property (nonatomic, readonly) NSArray *keywords;
@property (nonatomic, readonly) NSArray *contextualTags;

#pragma mark Formatted occurence
- (NSString *)formattedOccurence;
#pragma mark Formatted Day
- (NSString *) formattedDay;
#pragma mark Formatted Time
- (NSString *) formattedTime;
#pragma mark Adress formatting
- (NSString *)fullAdress;
#pragma mark Tags
- (BOOL)hasTags;
- (NSString *)tagAtIndex:(NSUInteger) index;
- (NSInteger)numberOfTags;
#pragma mark Formatted contextual tags
- (NSString *)formattedContextualTags;

@end
