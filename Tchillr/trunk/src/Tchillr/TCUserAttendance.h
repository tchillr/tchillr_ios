//
//  TCUserAttendance.h
//  Tchillr
//
//  Created by Jad on 27/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTCUserAttendanceChangedNotification @"kTCUserAttendanceChangedNotification"
#define kTCUserAttendanceYesKey @"yes"
#define kTCUserAttendanceMaybeKey @"maybe"
#define kTCUserAttendanceNoKey @"no"

@interface TCUserAttendance : NSObject

@property (nonatomic, retain) NSDictionary * attendances;

+ (TCUserAttendance *)sharedTchillrUserAttendances;

-(NSInteger)indexOfActivity:(NSNumber *) identifier;

@end