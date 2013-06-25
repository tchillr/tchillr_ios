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
#pragma mark All Activities (top 100 activities)
- (void)startActivitiesRequestWithSuccess:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure offset:(NSInteger) offset limit:(NSInteger)limit;
#pragma mark User Activities
- (void)startUserActivitiesRequestForDays:(NSUInteger)days success:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Themes (with their N2 tags)
- (void)startThemesRequestWithSuccess:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Interests
- (void)startInterestsRequestWithSuccess:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;
- (void)startUpdateInterestRequestWithIdentifier:(NSNumber*) interestIdentifier success:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;

@end
