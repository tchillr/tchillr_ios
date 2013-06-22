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
//#import "TCCategory.h"
#import "TCTag.h"

#define kTchillrServiceBaseURL @"http://tchillr.azurewebsites.net/TchillrService.svc/"
#define kTchillrServiceURL(x) [NSString stringWithFormat:@"%@%@",kTchillrServiceBaseURL,x]

// All Activities 
#define kTchillrServiceNameActivities @"DBActivities"
#define kTchillrAllActivitiesKey @"GetFromDBAllActivitiesResult"
// All Categories
#define kTchillrServiceNameCategories @"DBCategories"
#define kTchillrAllCategoriesKey @"GetDBCategoriesResult"
// All Themes
#define kTchillrServiceNameThemes @"Themes"
#define kTchillrAllThemesKey @"GetThemesResult"
// User Login
#warning needs to be changes with facebook login
#define USER_NAME_IDENTIFIER @"3"
// User Interests
#define kGetInterestsResult @"GetInterestsResult"
#define kPostInterestsResult @"PostInterestsResult"
#define kTchillrInterestBaseURI(identifier) [NSString stringWithFormat:@"users/%@/interests",identifier]
// User Activities
#define kTchillrUserActivitiesBaseURI(identifier) [NSString stringWithFormat:@"users/%@/activities",identifier]
#define kTchillrUserActivitiesActivitiesKey @"GetUserActivitiesResult"

#define kGetTagsResult @"GetTagsResult"

#define kTchillrServiceNameWithTheme(x) [NSString stringWithFormat:@"%@/Tags",x]
#define KTchillrInterestIdentifierKey @"identifier"

@implementation TCTchillrServerClient

#pragma mark Singleton
static TCTchillrServerClient *sharedTchillrServerClient;

+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedTchillrServerClient = [[TCTchillrServerClient alloc] initWithBaseURL:[NSURL URLWithString:kTchillrServiceBaseURL]];
	}
}
+ (TCTchillrServerClient *)sharedTchillrServerClient {
	return sharedTchillrServerClient;
}

#pragma mark All Activities
- (void)startActivitiesRequestWithSuccess:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure offset:(NSInteger) offset limit:(NSInteger)limit {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameActivities)]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultActivities = [[NSMutableArray alloc] init];
                                                                                            NSArray *activities = [jsonDict objectForKey:kTchillrAllActivitiesKey];
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
- (void)startUserActivitiesRequestWithSuccess:(void (^)(NSArray * activitiesArray))success failure:(void (^)(NSError *error))failure offset:(NSInteger) offset limit:(NSInteger)limit {
    NSString * urlString = kTchillrServiceURL(kTchillrUserActivitiesBaseURI(USER_NAME_IDENTIFIER));
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultActivities = [[NSMutableArray alloc] init];
                                                                                            NSArray *activities = [jsonDict objectForKey:kTchillrUserActivitiesActivitiesKey];
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

#pragma mark Categories
/*
- (void)startCategoriesRequestWithSuccess:(void (^)(NSArray * categoriesArray))success failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameCategories)]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultCategories = [[NSMutableArray alloc] init];
                                                                                            NSArray *categories = [jsonDict objectForKey:kTchillrAllCategoriesKey];
                                                                                            [categories enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCCategory * category = [[TCCategory alloc] initWithJsonDictionary:obj];
                                                                                                [resultCategories addObject:category];
                                                                                            }];
                                                                                            success(resultCategories);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                    NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}
 */

#pragma mark Themes (with their N2 tags)
- (void)startThemesRequestWithSuccess:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameThemes)]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultThemes = [[NSMutableArray alloc] init];
                                                                                            NSArray *themes = [jsonDict objectForKey:kTchillrAllThemesKey];
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

#pragma mark Tags for theme
- (void)startTagsRequestForTheme:(NSString *) themeString success:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameWithTheme(themeString))]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultTags = [[NSMutableArray alloc] init];
                                                                                            NSArray *tags = [jsonDict objectForKey:kGetTagsResult];
                                                                                            [tags enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
                                                                                                TCTag * tag = [[TCTag alloc] initWithJsonDictionary:obj];
                                                                                                [resultTags addObject:tag];
                                                                                            }];
                                                                                            success(resultTags);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

#pragma mark User interests

#pragma mark Get User interests
- (void)startInterestsRequestWithSuccess:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure {
    NSString * urlString = kTchillrServiceURL(kTchillrInterestBaseURI(USER_NAME_IDENTIFIER));
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSArray *tags = [jsonDict objectForKey:kGetInterestsResult];
                                                                                            success(tags);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }];
    [operation start];
}
#pragma mark Add/remove User interest
- (NSMutableURLRequest *)updateInterestRequestWithParameters:(NSDictionary *)parameters {
    NSString * path = kTchillrServiceURL(kTchillrInterestBaseURI(USER_NAME_IDENTIFIER));
    return [self requestWithMethod:@"POST" path:path parameters:parameters];
}

- (void)startUpdateInterestRequestWithIdentifier:(NSNumber*) interestIdentifier success:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure {
    NSDictionary * parameters = [NSDictionary dictionaryWithObject:interestIdentifier forKey:KTchillrInterestIdentifierKey];
    NSURLRequest *interestRequest = [self updateInterestRequestWithParameters:parameters];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:interestRequest
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSArray *tags = [jsonDict objectForKey:kPostInterestsResult];
                                                                                            success(tags);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

@end
