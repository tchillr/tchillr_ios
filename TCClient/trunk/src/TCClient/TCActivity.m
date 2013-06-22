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

- (CGFloat)longitude {
    return [(NSString *)[self.jsonDictionary objectForKey:kActivityLongitudeKey] floatValue];
}

- (CGFloat)latitude {
    return [(NSString *)[self.jsonDictionary objectForKey:kActivityLatitudeKey] floatValue];
}

- (NSString *)zipcode {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityZipcodeKey];
}

- (NSArray *)contextualTags {
    return (NSArray *)[self.jsonDictionary objectForKey:kActivityContextualTagsKey];
}

#pragma mark First access
- (TCOccurence *) firstOccurence {
   return (TCOccurence *) [self.occurences objectAtIndex:0];
}

#pragma mark Formatted occurence
- (NSString *)formattedOccurence{
    if ([self.occurences count]) {
        TCOccurence * firstOccurence = [self firstOccurence];
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

#pragma mark Formatted Day
- (NSString *) formattedDay{
    if ([self.occurences count]) {
        TCOccurence * firstOccurence = [self firstOccurence];
        NSString * formattedDay = [NSString stringWithFormat:@"%@",firstOccurence.day];
        return formattedDay;
    }
    return @"";
}

#pragma mark Formatted Time
- (NSString *) formattedTime{
    if ([self.occurences count]) {
        TCOccurence * firstOccurence = [self firstOccurence];
        NSString * formattedTime = [NSString stringWithFormat:@"%@-%@",firstOccurence.startTime,firstOccurence.endTime];
        return formattedTime;
    }
    return @"";
}

#pragma mark Tags
- (BOOL)hasTags{
    return [self.contextualTags count] > 0;
}

- (NSString *)tagAtIndex:(NSUInteger) index{
    return (NSString *)[self.contextualTags objectAtIndex:index];
}

- (NSInteger)numberOfTags{
    return [self.contextualTags count];
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
