//
//  TCServerClient.m
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCServerClient.h"
#import "AFJSONRequestOperation.h"
#import "TCActivity.h"
#import "TCTag.h"
#import "TCServerConstants.h"

#define user @"1"

@implementation TCServerClient

#pragma mark Singleton
static TCServerClient *sharedTchillrServerClient;

+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedTchillrServerClient = [[TCServerClient alloc] initWithBaseURL:[NSURL URLWithString:kTCServerBaseURL]];
	}
}
+ (TCServerClient *)sharedTchillrServerClient {
	return sharedTchillrServerClient;
}

#pragma mark Get Data from JSON
- (NSArray *) getDataFromJSON:(id)JSON {
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)JSON) objectForKey:KTCDataKey];
    }
    return nil;
}

#pragma mark All Activities
- (void)startActivitiesRequestWithSuccess:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure offset:(NSInteger) offset limit:(NSInteger)limit {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTCServerServiceURL(kTCServerActivities)]];
    NSLog(@"Request : %@", [[request URL] absoluteString]);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultActivities = [[NSMutableArray alloc] init];
                                                                                            NSArray *activities = [jsonDict objectForKey:kTCAllActivitiesKey];
                                                                                            [activities enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCActivity * activity = [[TCActivity alloc] initWithJsonDictionary:obj];
                                                                                                [resultActivities addObject:activity];
                                                                                            }];
                                                                                            success(resultActivities);
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                    NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

#pragma mark User Activities
- (void)startUserActivitiesRequestForDays:(NSUInteger)days success:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure {
    NSString * urlString = kTCServerServiceURL(kTCServerUserActivities(user, days));
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSLog(@"Request : %@", [[request URL] absoluteString]);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSArray *resultArray = [self getDataFromJSON:(NSDictionary *) JSON];
                                                                                            NSMutableArray * activities = [NSMutableArray array];
                                                                                            [resultArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCActivity * activity = [[TCActivity alloc] initWithJsonDictionary:obj];
                                                                                                [activities addObject:activity];
                                                                                            }];
                                                                                            success(activities);
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                    NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

#pragma mark Themes (with their N2 tags)
- (void)startThemesRequestWithSuccess:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTCServerServiceURL(KTCServerThemes)]];
    NSLog(@"Request : %@", [[request URL] absoluteString]);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultThemes = [[NSMutableArray alloc] init];
                                                                                            NSArray *themes = [jsonDict objectForKey:kTCAllThemesKey];
                                                                                            [themes enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCTheme * theme = [[TCTheme alloc] initWithJsonDictionary:obj];
                                                                                                [resultThemes addObject:theme];
                                                                                            }];
                                                                                            success(resultThemes);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

#pragma mark Get User interests
- (void)startInterestsRequestWithSuccess:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure {
    NSString * urlString = kTCServerServiceURL(kTCServerUserInterests(user));
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSLog(@"Request : %@", [[request URL] absoluteString]);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSArray *resultArray = [self getDataFromJSON:(NSDictionary *) JSON];
                                                                                            NSMutableArray * tags = [NSMutableArray array];
                                                                                            [resultArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCTag * tag = [[TCTag alloc] initWithJsonDictionary:obj];
                                                                                                [tags addObject:tag];
                                                                                            }];
                                                                                            success(tags);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }];
    [operation start];
}
#pragma mark Add/remove User interest
- (NSMutableURLRequest *)updateInterestRequestWithParameters:(NSDictionary *)parameters {
    NSString * path = kTCServerServiceURL(kTCServerUserInterests(user));
    return [self requestWithMethod:@"POST" path:path parameters:parameters];
}

- (void)startUpdateInterestRequestWithIdentifier:(NSNumber*) interestIdentifier success:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure {
    NSDictionary * parameters = [NSDictionary dictionaryWithObject:interestIdentifier forKey:KTCInterestIdentifierKey];
    NSURLRequest *request = [self updateInterestRequestWithParameters:parameters];
    NSLog(@"Request : %@", [[request URL] absoluteString]);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSArray *resultArray = [self getDataFromJSON:(NSDictionary *) JSON];
                                                                                            NSMutableArray * tags = [NSMutableArray array];
                                                                                            [resultArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCTag * tag = [[TCTag alloc] initWithJsonDictionary:obj];
                                                                                                [tags addObject:tag];
                                                                                            }];
                                                                                            success(tags);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

@end
