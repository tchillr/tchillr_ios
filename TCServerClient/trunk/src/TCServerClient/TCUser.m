//
//  TCUser.m
//  TCServerClient
//
//  Created by Jad on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCUser.h"

#define kUserIdentifierKey @"identifier"

@implementation TCUser

+ (NSString *)identifier {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userIdentifier = [userDefaults objectForKey:kUserIdentifierKey];
    if (!userIdentifier) {
        userIdentifier = [[NSUUID UUID] UUIDString];
        [userDefaults setObject:userIdentifier forKey:kUserIdentifierKey];
    }
    return userIdentifier;
}

@end
