//
//  TCTheme.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTheme.h"

#define kThemeTitleKey @"title"
#define kThemeIdentifierKey @"identifier"
#define kThemeTagsKey @"tags"


@implementation TCTheme

- (NSString *)title {
    return (NSString *)[self.jsonDictionary objectForKey:kThemeTitleKey];
}

- (NSArray *)tags {
    return (NSArray *)[self.jsonDictionary objectForKey:kThemeTagsKey];
}

- (NSNumber *)identifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:kThemeIdentifierKey];
}

@end
