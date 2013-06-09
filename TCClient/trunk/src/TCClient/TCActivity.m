//
//  TCActivity.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivity.h"
#import "TCKeyword.h"

#define kActivityDescriptionKey @"description"
#define kActivityShortDescriptionKey @"shortDescription"
#define kActivityOccurencesKey @"occurences"
#define kActivityNameKey @"name"
#define kActivityCityKey @"city"
#define kActivityIdentifierKey @"identifier"
#define kActivityPlaceKey @"place"
#define kActivityAddressKey @"adress"
#define kActivityLongitudeKey @"longitude"
#define kActivityLatitudeKey @"latitude"
#define kActivityZipcodeKey @"zipcode"
#define kActivityKeywordsKey @"keywords"

#define kActivityWordKey @"Key"
#define kActivityWeightKey @"Value"

@implementation TCActivity

#pragma mark Accessors
- (NSString *)description {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityDescriptionKey];
}

- (NSString *)shortDescription {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityShortDescriptionKey];
}

- (NSArray *)occurences {
    return (NSArray *)[self.jsonDictionary objectForKey:kActivityOccurencesKey];
}

- (NSString *)name {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityNameKey];
}

- (NSString *)city {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityCityKey];
}

- (NSNumber *)identifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:kActivityIdentifierKey];
}

- (NSString *)place {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityPlaceKey];
}

- (NSString *)adress {
   return (NSString *)[self.jsonDictionary objectForKey:kActivityAddressKey];
}

- (NSString *)longitude {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityLongitudeKey];
}

- (NSString *)latitude {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityLatitudeKey];
}

- (NSString *)zipcode {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityZipcodeKey];
}

- (NSArray *)keywords {
    NSMutableArray * keywords = [NSMutableArray array];
    NSArray * keywordDictionnaries = (NSArray *)[self.jsonDictionary objectForKey:kActivityKeywordsKey];
    for (NSDictionary * dict in keywordDictionnaries) {
        TCKeyword * keyword = [[TCKeyword alloc] initWithWord:[dict objectForKey:kActivityWordKey] andWeight:[[dict objectForKey:kActivityWeightKey] intValue]];
        [keywords addObject:keyword];
    }
    return [NSArray arrayWithArray:keywords];
}

@end
