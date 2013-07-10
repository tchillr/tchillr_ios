//
//  TCServerClient.h
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCTheme.h"
#import "AFHTTPClient.h"

@interface TCServerClient : AFHTTPClient

/** @name Singleton */
#pragma mark Singleton
+ (TCServerClient *)sharedTchillrServerClient;
#pragma mark User Activities with from/to dates
- (void)startUserActivitiesRequestFrom:(NSDate *) fromDate to:(NSDate *) toDate success:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure;


#pragma mark Themes (with their N2 tags)
- (void)startThemesRequestWithSuccess:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Interests
- (void)startInterestsRequestWithSuccess:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;
// Use this method to remove every taste of the user and fill in some new ones with your array
- (void)startRefreshInterestRequestWithInterestsList:(NSArray*) interestsList success:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;
// Use this method to select every taste that weren't previously owned by the user and remove every ones that were already in database with you interest tag list
- (void)startUpdateInterestRequestWithInterestsList:(NSArray*) interestsList success:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Images Loading
- (void)startImageRequestForURLString:(NSString *)imageURLString success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
#pragma mark User Login
- (void)startUserCreationRequestForUUIDString:(NSString *)UUIDString success:(void (^)(BOOL success))success failure:(void (^)(NSError *error))failure;

@end
