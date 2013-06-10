//
//  TCOccurence.h
//  TCClient
//
//  Created by Jad on 10/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

#define kOccurenceDayKey @"jour"
#define kOccurenceStartTimeKey @"hour_start"
#define kOccurenceEndTimeKey @"hour_end"

@interface TCOccurence : TCObject

@property (nonatomic, retain) NSString* day;
@property (nonatomic, retain) NSString* startTime;
@property (nonatomic, retain) NSString* endTime;

@end
