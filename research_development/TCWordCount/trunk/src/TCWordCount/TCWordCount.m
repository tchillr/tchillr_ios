//
//  TCWordCount.m
//  TCWordCount
//
//  Created by Zouhair on 04/06/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import "TCWordCount.h"

@interface TCWordCount()

@property (strong, nonatomic, readwrite) NSString *word;

@end

@implementation TCWordCount

- (id)initWithWord:(NSString *)word {
	self = [super init];
	if (self) {
		[self setWord:word];
		[self setCount:0];
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ {word : %@, count : %d}", [super description], self.word, self.count];
}


@end
