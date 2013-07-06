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
#pragma mark User Activities with from/to dates
- (void)startUserActivitiesRequestFrom:(NSDate *) fromDate to:(NSDate *) toDate success:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure;


#pragma mark Themes (with their N2 tags)
- (void)startThemesRequestWithSuccess:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Interests
- (void)startInterestsRequestWithSuccess:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;
- (void)startUpdateInterestRequestWithIdentifier:(NSNumber*) interestIdentifier success:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Images Loading
- (void)startImageRequestForURLString:(NSString *)imageURLString success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
#pragma mark User Login
- (void)startUserCreationRequestForUUIDString:(NSString *)UUIDString success:(void (^)(BOOL success))success failure:(void (^)(NSError *error))failure;

@end
