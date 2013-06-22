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

#pragma mark Start/End time Formatting
- (NSString *)formatTime:(NSString *)time {
    NSMutableString* mTime = [time mutableCopy];
    [mTime replaceOccurrencesOfString:@":" withString:@"h" options:NSLiteralSearch range:NSMakeRange(0, [mTime length])];
    NSString * formattedTime = [mTime substringToIndex:5];
    BOOL isExactHour = ([formattedTime rangeOfString:@"h00"].location != NSNotFound);
    if (isExactHour) {
        formattedTime = [formattedTime substringToIndex:3];
    }
    return formattedTime;
}

- (NSString *)startTime {
    NSString * startTimeString = (NSString *)[self.jsonDictionary objectForKey:kOccurenceStartTimeKey];
    return [self formatTime:startTimeString];
}

- (NSString *)endTime {
    NSString * endTimeString = (NSString *)[self.jsonDictionary objectForKey:kOccurenceEndTimeKey];
    return [self formatTime:endTimeString];
}


@end
