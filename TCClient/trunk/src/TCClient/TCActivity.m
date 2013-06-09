//
//  TCActivity.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivity.h"
#import "TCKeyword.h"
#import "NSString+TCAdditions.h"

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

#pragma mark Adress formatting
- (NSString *)fullAdress{
    NSMutableString * fullAdress = [[NSMutableString alloc] init];
    NSMutableArray * availableStrings = [[NSMutableArray alloc]init];
    
    if (![self.place isEmpty]) {
        [availableStrings addObject:[self.place capitalizedString]];
    }
    if (![self.adress isEmpty]) {
        [availableStrings addObject:[self.adress capitalizedString]];
    }
    if (![self.zipcode isEmpty]) {
        [availableStrings addObject:[self.zipcode capitalizedString]];
    }
    if (![self.city isEmpty]) {
        [availableStrings addObject:[self.city capitalizedString]];
    }

    for (int i = 0; i < [availableStrings count]; i++) {
        if (i == [availableStrings count] - 1) {
            [fullAdress appendFormat:@"%@.",[availableStrings objectAtIndex:i]];
        }
        else {
            [fullAdress appendFormat:@"%@, ",[availableStrings objectAtIndex:i]];
        }
    }
    return [NSString stringWithString:fullAdress];
}


@end
