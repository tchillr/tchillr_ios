//
//  TCOccurence.m
//  TCClient
//
//  Created by Jad on 10/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCOccurence.h"

#define API_PARIS_DATE_FORMAT

@implementation TCOccurence

#pragma mark Accessors
- (NSString *)day {
    NSString * dayString = (NSString *)[self.jsonDictionary objectForKey:kOccurenceDayKey];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:dayString];
    [dateFormat setDateFormat:@"dd MMM"];
    NSString * formattedDay = [dateFormat stringFromDate:date];
    return formattedDay;
}

- (NSString *)startTime {
    NSString * startTimeString = (NSString *)[self.jsonDictionary objectForKey:kOccurenceStartTimeKey];
    NSString * formattedStartTime = [startTimeString substringToIndex:5];
    return formattedStartTime;
}

- (NSString *)endTime {
    NSString * endTimeString = (NSString *)[self.jsonDictionary objectForKey:kOccurenceEndTimeKey];
    NSString * formattedEndTime = [endTimeString substringToIndex:5];
    return formattedEndTime;
}


@end
