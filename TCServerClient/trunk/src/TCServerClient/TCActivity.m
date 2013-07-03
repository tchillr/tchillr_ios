//
//  TCActivity.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

// Categories
#import "NSString+TCAdditions.h"
// Model
#import "TCActivity.h"
#import "TCTag.h"
#import "TCMedia.h"
#import "TCOccurence.h"

#define kActivityDescriptionKey @"description"
#define kActivityShortDescriptionKey @"shortDescription"
#define kActivityOccurencesKey @"Occurences"
#define kActivityNameKey @"name"
#define kActivityCityKey @"city"
#define kActivityIdentifierKey @"identifier"
#define kActivityPlaceKey @"place"
#define kActivityAddressKey @"adress"
#define kActivityLongitudeKey @"longitude"
#define kActivityLatitudeKey @"latitude"
#define kActivityZipcodeKey @"zipcode"
#define kActivityKeywordsKey @"keywords"
#define kActivityTagsKey @"tags"
#define kActivityAccessTypeKey @"accessType"
#define kActivityPriceKey @"price"
#define kActivityHasFeeKey @"hasFee"
#define kActivityScoreKey @"score"
#define kActivityMediaKey @"Media"


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

- (NSString *)address {
   return (NSString *)[self.jsonDictionary objectForKey:kActivityAddressKey];
}

- (CGFloat)longitude {
    return [(NSString *)[self.jsonDictionary objectForKey:kActivityLongitudeKey] floatValue];
}

- (CGFloat)latitude {
    return [(NSString *)[self.jsonDictionary objectForKey:kActivityLatitudeKey] floatValue];
}

- (NSNumber *)zipcode {
    return (NSNumber *)[self.jsonDictionary objectForKey:kActivityZipcodeKey];
}

- (NSArray *)tags {
    NSMutableArray * tagsArray = [[NSMutableArray alloc]init];
    NSArray * tags = (NSArray *)[self.jsonDictionary objectForKey:kActivityTagsKey];
    
    for (NSDictionary * tagsDict in tags) {
        TCTag * tag = [[TCTag alloc]initWithJsonDictionary:tagsDict];
        [tagsArray addObject:tag];
    }
    return [NSArray arrayWithArray:tagsArray];
}

- (NSString *)accessType {
    return (NSString *)[self.jsonDictionary objectForKey:kActivityAccessTypeKey];
}

- (NSNumber *)price {
    return (NSNumber *)[self.jsonDictionary objectForKey:kActivityPriceKey];
}

- (BOOL)hasFee {
    return [(NSNumber *)[self.jsonDictionary objectForKey:kActivityHasFeeKey] boolValue];
}

- (NSNumber *)score {
    return (NSNumber *)[self.jsonDictionary objectForKey:kActivityScoreKey];
}

#warning Medias support / only images files
@synthesize medias = _medias;
- (NSArray *)medias {
    if (!_medias) {
        NSArray * medias = [self.jsonDictionary objectForKey:kActivityMediaKey];
        NSMutableArray * mediasArray = [NSMutableArray array];
        for (int i = 0; i < [medias count]; i++) {
            NSDictionary * mediaDictionnary = [medias objectAtIndex:i];
            TCMedia * media = [[TCMedia alloc] initWithJsonDictionary:mediaDictionnary];
            if ([[media.path pathExtension] isEqualToString:@"jpg"]) {
                [mediasArray addObject:media];
            }    
        }
        _medias = [NSArray arrayWithArray:mediasArray];
    }
    return _medias;
}
#pragma mark Medias access
- (TCMedia *)mediaAtIndex:(NSInteger)index {
    return [self.medias objectAtIndex:index];
}

- (NSInteger)numberOfMedias {
    return [self.medias count];
}

- (BOOL)hasMedias {
    NSInteger index = [self.medias indexOfObjectPassingTest:^BOOL(TCMedia * media, NSUInteger idx, BOOL *stop) {
        return (media.image != nil);
    }];
    return index != NSNotFound;
}

#pragma mark First access
- (TCOccurence *) firstOccurence {
   return (TCOccurence *) [self.occurences objectAtIndex:0];
}

#pragma mark Formatted Address 
- (NSString *)fullAddress{
    NSMutableString * fullAdress = [[NSMutableString alloc] init];
    NSMutableArray * availableStrings = [[NSMutableArray alloc]init];
    
    if (![self.address isEqualToString:@""]) {
        [availableStrings addObject:[self.address capitalizedString]];
    }
    if (self.zipcode) {
        [availableStrings addObject:[NSString stringWithFormat:@"%@",self.zipcode]];
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

#pragma mark Formatted Access Type / Price
- (NSString*) formattedAccessTypeAndPrice {
    NSString * formattedAccessTypeAndPrice = nil;
    if (self.hasFee) {
        formattedAccessTypeAndPrice = [NSString stringWithFormat:@"%@ / %@",self.accessType,self.price];
    }
    else {
        formattedAccessTypeAndPrice = [NSString stringWithFormat:@"%@",self.accessType];
    }    
    return formattedAccessTypeAndPrice;
}

#pragma mark Tags
- (BOOL)hasTags{
    return [self.tags count] > 0;
}

- (TCTag *)tagAtIndex:(NSUInteger) index{
    return [self.tags objectAtIndex:index];
}

- (NSInteger)numberOfTags{
    return [self.tags count];
}

#pragma mark Formatted Tags
- (NSString *)formattedTags{
    NSMutableString * fullTags = [[NSMutableString alloc] init];
    for (int i = 0; i < [self.tags count]; i++) {
        if (i == [self.tags count] - 1) {
            [fullTags appendFormat:@"%@",((TCTag *)[self.tags objectAtIndex:i]).title];
        }
        else {
            [fullTags appendFormat:@"%@ / ",((TCTag *)[self.tags objectAtIndex:i]).title];
        }
    }
    return [[NSString stringWithString:fullTags] uppercaseString];
}

@end
