//
//  TCCategory.h
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

@interface TCCategory : TCObject

@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSString *name;

@end
