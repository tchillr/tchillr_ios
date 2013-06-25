//
//  TCTheme.h
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCObject.h"

@class TCTag;

@interface TCTheme : TCObject

@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSArray *tags;
#warning Element d'interface : ne devrait pas être là
@property (nonatomic, assign, getter = isOpen) BOOL open;

#pragma mark Tag Access
- (TCTag *)tagAtIndex:(NSInteger)index;

@end
