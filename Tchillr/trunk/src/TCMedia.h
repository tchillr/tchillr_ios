//
//  TCMedia.h
//  Tchillr
//
//  Created by Jad on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCObject.h"

@interface TCMedia : TCObject

@property (nonatomic, readonly) NSString * path;
@property (nonatomic, readonly) NSString * type;
@property (nonatomic, readonly) NSString * credit;
@property (nonatomic, readonly) NSString * caption;

@end
