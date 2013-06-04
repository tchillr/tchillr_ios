//
//  TCWordCount.h
//  TCWordCount
//
//  Created by Zouhair on 04/06/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCWordCount : NSObject

@property (strong, nonatomic, readonly) NSString *word;
@property (assign, nonatomic) NSUInteger count;

- (id)initWithWord:(NSString *)word;

@end
