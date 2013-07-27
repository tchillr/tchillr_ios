//
//  TCUserInterest.m
//  Tchillr
//
//  Created by Jad on 08/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCUserInterests.h"
#import "TCTag.h"

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

-(void)setInterests:(NSArray *)interests{
    _interests = interests;
    [[NSNotificationCenter defaultCenter] postNotificationName:kTCUserInterestsChangedNotification object:nil];
}

-(BOOL)containsTagIdentifier:(NSNumber *) identifier{
    NSInteger index  = [_interests indexOfObjectPassingTest:^BOOL(TCTag * tag, NSUInteger idx, BOOL *stop) {
        return [tag.identifier isEqualToNumber:identifier];
    }];
    return index != NSNotFound;
}

@end
