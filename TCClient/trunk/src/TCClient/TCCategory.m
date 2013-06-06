//
//  TCCategory.m
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCCategory.h"

#define kCategoryNameKey @"name"
#define kCategoryIdentifierKey @"identifier"

@implementation TCCategory

#pragma mark Accessors
- (NSString *)name {
    return (NSString *)[self.jsonDictionary objectForKey:kCategoryNameKey];
}

- (NSNumber *)identifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:kCategoryIdentifierKey];
}

@end
