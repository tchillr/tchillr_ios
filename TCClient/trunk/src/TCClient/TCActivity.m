//
//  TCActivity.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivity.h"
#import "TCKeyword.h"
#import "TCOccurence.h"
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
#define kActivityContextualTagsKey @"activityContextualTags"

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
    NSMutableArray * occurences = [NSMutableArray array];
    NSArray * occurencesDictionnaries = (NSArray *)[self.jsonDictionary objectForKey:kActivityOccurencesKey];
    for (NSDictionary * dict in occurencesDictionnaries) {
        TCOccurence * occurence = [[TCOccurence alloc] initWithJsonDictionary:dict];
        [occurences addObject:occurence];
    }
    return [NSArray arrayWithArray:occurences];
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

- (NSArray *)contextualTags {
    return (NSArray *)[self.jsonDictionary objectForKey:kActivityContextualTagsKey];
}

#pragma mark Formatted occurence
- (NSString *)formattedOccurence{
    if ([self.occurences count]) {
        TCOccurence * firstOccurence = (TCOccurence *) [self.occurences objectAtIndex:0];
        NSString * formattedOccurence = [NSString stringWithFormat:@"Le %@ de %@ à %@",firstOccurence.day,firstOccurence.startTime,firstOccurence.endTime];
        return formattedOccurence;
    }
    return @"";    
}

#pragma mark Formatted Adress 
- (NSString *)fullAdress{
    NSMutableString * fullAdress = [[NSMutableString alloc] init];
    NSMutableArray * availableStrings = [[NSMutableArray alloc]init];
    
    if (![self.place isEqualToString:@""]) {
        [availableStrings addObject:[self.place capitalizedString]];
    }
    if (![self.adress isEqualToString:@""]) {
        [availableStrings addObject:[self.adress capitalizedString]];
    }
    if (![self.zipcode isEqualToString:@""]) {
        [availableStrings addObject:[self.zipcode capitalizedString]];
    }
    if (![self.city isEqualToString:@""]) {
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

#pragma mark Tags
- (BOOL)hasTags{
    return [self.contextualTags count] > 0;
}

#pragma mark Formatted contextual tags
- (NSString *)formattedContextualTags{
    NSMutableString * fullTags = [[NSMutableString alloc] init];
    for (int i = 0; i < [self.contextualTags count]; i++) {
        if (i == [self.contextualTags count] - 1) {
            [fullTags appendFormat:@"%@",[self.contextualTags objectAtIndex:i]];
        }
        else {
            [fullTags appendFormat:@"%@ / ",[self.contextualTags objectAtIndex:i]];
        }
    }
    return [NSString stringWithString:fullTags];
}


@end
