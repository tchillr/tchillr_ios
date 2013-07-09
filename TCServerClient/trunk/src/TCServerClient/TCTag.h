//
//  TCTag.h
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"
#import "TCActivity.h"

@interface TCTag : TCObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSNumber *themeIdentifier;

- (TCActivityColorStyle)colorStyle;

@end
