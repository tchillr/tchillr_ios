//
//  TCMedia.m
//  Tchillr
//
//  Created by Jad on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCMedia.h"

#define kMediaPathKey @"path"
#define kMediaTypeKey @"type"
#define kMediaCreditKey @"credit"
#define kMediaCaptionKey @"caption"

@implementation TCMedia

- (NSString *)path {
    return [self.jsonDictionary objectForKey:kMediaPathKey];
}

- (NSString *)type {
    return [self.jsonDictionary objectForKey:kMediaTypeKey];
}

- (NSString *)credit {
    return [self.jsonDictionary objectForKey:kMediaCreditKey];
}

- (NSString *)caption {
    return [self.jsonDictionary objectForKey:kMediaCaptionKey];
}

@end
