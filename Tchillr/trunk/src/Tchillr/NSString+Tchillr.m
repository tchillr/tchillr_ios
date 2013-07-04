//
//  NSString+Tchillr.m
//  Tchillr
//
//  Created by Jad on 04/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "NSString+Tchillr.h"

@implementation NSString (Tchillr)

- (NSString *)stringWithCapitalizedFirstWord {
    NSString * stringWithCapitalizedFirstWord = nil;
    if ([self length] > 0) {
        stringWithCapitalizedFirstWord = [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]];
    }
    return stringWithCapitalizedFirstWord;
}



@end
