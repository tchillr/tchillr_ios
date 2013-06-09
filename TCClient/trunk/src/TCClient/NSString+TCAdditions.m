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

@end
