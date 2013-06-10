//
//  TCOccurence.m
//  TCClient
//
//  Created by Jad on 10/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCOccurence.h"

@implementation TCOccurence

#pragma mark Accessors
- (NSString *)day {
    return (NSString *)[self.jsonDictionary objectForKey:kOccurenceDayKey];
}

- (NSString *)startTime {
    return (NSString *)[self.jsonDictionary objectForKey:kOccurenceStartTimeKey];
}

- (NSString *)endTime {
    return (NSString *)[self.jsonDictionary objectForKey:kOccurenceEndTimeKey];
}


@end
