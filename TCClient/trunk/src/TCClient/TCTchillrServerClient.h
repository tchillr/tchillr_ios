//
//  TCServerClient.h
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCTheme.h"

@interface TCTchillrServerClient : NSObject

/** @name Singleton */
#pragma mark Singleton
+ (TCTchillrServerClient *)sharedTchillrServerClient;
#pragma mark Activities
- (void)startActivitiesRequestWithSuccess:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure offset:(NSInteger) offset limit:(NSInteger)limit;
#pragma mark Categories
- (void)startCategoriesRequestWithSuccess:(void (^)(NSArray * categoriesArray))success failure:(void (^)(NSError *error))failure;
#pragma mark Tags for theme
- (void)startTagsRequestForTheme:(TCThemeType) themeType success:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure;

#pragma mark User User interests
- (void)startTagsRequestForInterestsWithSuccess:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure;

@end
