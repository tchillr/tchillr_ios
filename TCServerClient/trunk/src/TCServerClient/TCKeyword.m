//
//  TCKeyword.m
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCKeyword.h"

@implementation TCKeyword

#pragma mark LifeCycle
- (id)initWithWord:(NSString *)word andWeight:(NSInteger)weight{
	self = [super init];
	if (self) {
		[self setWord:word];
		[self setWeight:weight];
	}
	return self;
}



@end
