//
//  TCKeyword.h
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCObject.h"

@interface TCKeyword : TCObject

@property (nonatomic, retain) NSString* word;
@property (nonatomic, assign) NSInteger weight;


- (id)initWithWord:(NSString *)word andWeight:(NSInteger)weight;

@end
