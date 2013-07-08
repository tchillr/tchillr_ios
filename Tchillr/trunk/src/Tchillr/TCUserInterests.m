//
//  TCUserInterest.m
//  Tchillr
//
//  Created by Jad on 08/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCUserInterests.h"

@implementation TCUserInterests


#pragma mark Singleton
static TCUserInterests *sharedTchillrUserInterests;

+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedTchillrUserInterests = [[TCUserInterests alloc] init];
	}
}
+ (TCUserInterests *)sharedTchillrUserInterests {
	return sharedTchillrUserInterests;
}

@end
