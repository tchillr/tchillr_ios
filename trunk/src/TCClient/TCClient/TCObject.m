//
//  TCObject.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

@implementation TCObject

@synthesize jsonDictionary = _jsonDictionary;
- (void)setJsonDictionary:(NSDictionary *)jsonDictionary {
	if (![_jsonDictionary isEqualToDictionary:jsonDictionary]) {
		_jsonDictionary = jsonDictionary;
	}
}

#pragma mark - Initializer
- (id)initWithJsonDictionary:(NSDictionary *)jsonDictionary {
	self = [super init];
	if (self) {
		self.jsonDictionary = jsonDictionary;
	}
	return self;
}

#pragma mark - Static Initializer
+ (TCObject *)objectWithJsonDictionary:(NSDictionary *)jsonDictionary {
	return [[self alloc] initWithJsonDictionary:jsonDictionary];
}

@end
