//
//  TCServerClient.h
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCTchillrServerClient : NSObject

/** @name Singleton */
#pragma mark Singleton
+ (TCTchillrServerClient *)sharedTchillrServerClient;
#pragma mark (api.paris.fr) Activities
- (void)startActivitiesRequest:(NSMutableArray *)currentActivities success:(void (^)(BOOL activitiesRequestSucceeded))success failure:(void (^)(NSError *error))failure offset:(NSInteger) offset limit:(NSInteger)limit;
#pragma mark (api.paris.fr) Categories
- (void)startCategoriesRequest:(NSMutableArray *)currentCategories success:(void (^)(BOOL categoriesRequestSucceeded))success failure:(void (^)(NSError *error))failure;
@end
