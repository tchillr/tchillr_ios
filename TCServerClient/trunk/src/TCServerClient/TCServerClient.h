//
//  TCServerClient.h
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCTheme.h"
#import "TCActivity.h"
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
- (void)startRefreshInterestRequestWithInterestsList:(NSArray*) interestsList success:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Get User Attendance
- (void)startAttendanceRequestWithSuccess:(void (^)(NSDictionary  * attendanceDict))success failure:(void (^)(NSError *error))failure;
#pragma mark Update Activity Attendance
- (void)startUpdateActivityAttendance:(NSString *) attendance forActivityWithIdentifier:(NSString *) identifier success:(void (^)(void))success failure:(void (^)(NSError *error))failure;
#pragma mark Images Loading
- (void)startImageRequestForURLString:(NSString *)imageURLString success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
#pragma mark User Login
- (void)startUserCreationRequestForUUIDString:(NSString *)UUIDString success:(void (^)(BOOL success))success failure:(void (^)(NSError *error))failure;

@end
