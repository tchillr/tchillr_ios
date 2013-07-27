//
//  TCUserAttendance.m
//  Tchillr
//
//  Created by Jad on 27/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCUserAttendance.h"

@implementation TCUserAttendance

#pragma mark Singleton
static TCUserAttendance *sharedTchillrUserAttendances;

+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedTchillrUserAttendances = [[TCUserAttendance alloc] init];
	}
}

+ (TCUserAttendance *)sharedTchillrUserAttendances {
	return sharedTchillrUserAttendances;
}

-(NSInteger)indexOfActivity:(NSNumber *) identifier{
    NSInteger index = NSNotFound;
    if ([[_attendances objectForKey:kTCUserAttendanceYesKey] containsObject:identifier]) {
        index = 0;
    }
    else if ([[_attendances objectForKey:kTCUserAttendanceMaybeKey] containsObject:identifier]) {
        index = 1;
    }
    else if ([[_attendances objectForKey:kTCUserAttendanceNoKey] containsObject:identifier]) {
        index = 2;
    }
    return index;   
}

-(void)setAttendances:(NSDictionary *)attendances{
    _attendances = attendances;
    [[NSNotificationCenter defaultCenter] postNotificationName:kTCUserAttendanceChangedNotification object:nil];
}

@end