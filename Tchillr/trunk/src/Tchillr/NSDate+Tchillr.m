//
//  NSDate+Tchillr.m
//  Tchillr
//
//  Created by Jad on 06/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "NSDate+Tchillr.h"

@implementation NSDate (Tchillr)

#pragma mark Date components formatting
-(NSString *) formattedDateComponent:(NSInteger)dateComponent {
    NSString * formattedDateComponent = nil;
    if (dateComponent < 10) {
        formattedDateComponent = [NSString stringWithFormat:@"0%i",dateComponent];
    }
    else {
        formattedDateComponent = [NSString stringWithFormat:@"%i",dateComponent];
    }
    return formattedDateComponent;
}

-(NSString *)formattedDate{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    NSString * day = [self formattedDateComponent:[components day]];
    NSString * month = [self formattedDateComponent:[components month]];
    NSInteger year = [components year];
    NSString * hour = [self formattedDateComponent:[components hour]];
    NSString * minutes = [self formattedDateComponent:[components minute]];
    return [NSString stringWithFormat:@"%i%@%@%@%@00", year, month, day, hour, minutes];
}

@end
