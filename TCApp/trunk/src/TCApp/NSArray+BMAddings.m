//
//  NSArray+BMAddings.m
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "NSArray+BMAddings.h"
#import "TCInterestPickerItemModel.h"

@implementation NSArray (BMAddings)

/*
- (NSArray *)initWithTitlesBackgroundColorsAndTitleColors:(id)objects, ... {
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    va_list args;
    va_start(args, objects);
    
    int i = 0;
    TCInterestPickerItemModel *interestItem = nil;
    NSString *tmpTitle = nil;
    UIColor *tmpBackgroundColor = nil;
    
    for (id arg = objects; arg != nil; arg = va_arg(args,id))
    {
        i++;
        //NSLog(@"item %i : %@",i,arg);
        if(i%3 == 1) {
            tmpTitle = [NSString stringWithString:arg];
        }
        else if(i%3 == 2) {
            tmpBackgroundColor = [UIColor colorWithCGColor:[(UIColor *)arg CGColor]];
        }
        else {
            interestItem = [[TCInterestPickerItemModel alloc] initWithTitle:tmpTitle backgroundColor:tmpBackgroundColor andTitleColor:arg];
            [tmpArray addObject:interestItem];
        }
    }
    
    va_end(args);
    
    self = [self initWithArray:tmpArray];
    
    if(self) {
        
    }
    
    return self;
}
 */

@end
