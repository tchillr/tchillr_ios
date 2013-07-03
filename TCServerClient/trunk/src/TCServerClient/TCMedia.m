//
//  TCMedia.m
//  Tchillr
//
//  Created by Jad on 01/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCServerClient.h"
#import "TCMedia.h"

#define kMediaPathKey @"path"
#define kMediaTypeKey @"type"
#define kMediaCreditKey @"credit"
#define kMediaCaptionKey @"caption"

@interface TCMedia()

#pragma mark Web Images lazy loading
@property (nonatomic, assign, getter = isImageLazilyLoading) BOOL imageLazilyLoading;

@end

@implementation TCMedia

@synthesize image = _image;

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

#pragma mark Media Web Images lazy loading
- (void)loadImageWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    if (![self isImageLazilyLoading]) {
		[self setImageLazilyLoading:YES];
		[[TCServerClient sharedTchillrServerClient] startImageRequestForURLString:self.path success:^(UIImage *image) {
            self.image = image;
            [self setImageLazilyLoading:NO];
            success();
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [self setImageLazilyLoading:NO];
            failure(error);
        }];
	}
}

@end
