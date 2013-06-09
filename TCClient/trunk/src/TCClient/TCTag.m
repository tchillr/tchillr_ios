//
//  TCTag.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTag.h"
#define kTagTitleKey @"title"
#define kTagWeightKey @"weight"
#define kTagIdentifierKey @"identifier"



@implementation TCTag

#pragma mark Accessors
- (NSString *)title {
    return (NSString *)[self.jsonDictionary objectForKey:kTagTitleKey];
}

- (NSInteger)weight {
    return [(NSString *)[self.jsonDictionary objectForKey:kTagWeightKey] intValue];
}

- (NSNumber*)identifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:kTagIdentifierKey];
}

@end
