//
//  NSString+TCAdditions.m
//  TCClient
//
//  Created by Jad on 09/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "NSString+TCAdditions.h"

@implementation NSString (TCAdditions)

- (BOOL)isEmpty {
    if ( ([self length] == 0) || ![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ) {
        return YES;
    }    
    return NO;
}

- (NSString *)getFirstCharacterCapitalized {
    return ([self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]]);
}
@end
