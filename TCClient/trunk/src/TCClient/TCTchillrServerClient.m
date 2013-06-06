//
//  TCServerClient.m
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTchillrServerClient.h"
#import "AFJSONRequestOperation.h"
#import "TCActivity.h"
#import "TCCategory.h"

#define kTchillrServiceBaseURL @"http://tchillr.azurewebsites.net/TchillrService.svc/"
#define kTchillrServiceURL(x) [NSString stringWithFormat:@"%@%@",kTchillrServiceBaseURL,x]
#define kTchillrServiceNameActivities @"StaticActivities"
#define kTchillrServiceNameCategories @"StaticCategories"
#define kTchillrAllActivitiesKey @"GetStaticAllActivitiesResult"
#define kTchillrAllCategoriesKey @"GetStaticCategoriesResult"

@implementation TCTchillrServerClient

#pragma mark Singleton
static TCTchillrServerClient *sharedTchillrServerClient;

+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedTchillrServerClient = [[TCTchillrServerClient alloc] init];
	}
}
+ (TCTchillrServerClient *)sharedTchillrServerClient {
	return sharedTchillrServerClient;
}

#pragma mark (api.paris.fr) Activities
- (void)startActivitiesRequest:(NSMutableArray *)currentActivities success:(void (^)(BOOL activitiesRequestSucceeded))success failure:(void (^)(NSError *error))failure offset:(NSInteger) offset limit:(NSInteger)limit {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameActivities)]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSArray *activities = [jsonDict objectForKey:kTchillrAllActivitiesKey];
                                                                                            [activities enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCActivity * activity = [[TCActivity alloc] initWithJsonDictionary:obj];
                                                                                                [currentActivities addObject:activity];
                                                                                                success(YES);
                                                                                            }];                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                    NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    [operation setJSONReadingOptions:NSJSONReadingAllowFragments];
    [operation start];
    
}

#pragma mark (api.paris.fr) Categories

- (void)startCategoriesRequest:(NSMutableArray *)currentCategories success:(void (^)(BOOL categoriesRequestSucceeded))success failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameCategories)]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSArray *categories = [jsonDict objectForKey:kTchillrAllCategoriesKey];
                                                                                            [categories enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCCategory * category = [[TCCategory alloc] initWithJsonDictionary:obj];
                                                                                                [currentCategories addObject:category];
                                                                                                success(YES);
                                                                                            }];
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                    NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    [operation setJSONReadingOptions:NSJSONReadingAllowFragments];
    [operation start];
}

@end
