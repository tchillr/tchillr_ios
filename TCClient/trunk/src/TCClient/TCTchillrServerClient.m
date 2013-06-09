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
#import "TCTag.h"


// Login
#warning needs to be changes with facebook login
#define USER_NAME_IDENTIFIER @"1"
#define kTchillrServiceBaseURL @"http://tchillr.azurewebsites.net/TchillrService.svc/"
#define kTchillrServiceURL(x) [NSString stringWithFormat:@"%@%@",kTchillrServiceBaseURL,x]

// Activities 
#define kTchillrServiceNameActivities @"DBActivities"
#define kTchillrAllActivitiesKey @"GetFromDBAllActivitiesResult"

// Categories
#define kTchillrServiceNameCategories @"StaticCategories"
#define kTchillrAllCategoriesKey @"GetStaticCategoriesResult"

// Interests
#define kTchillrInterestsKey @"GetInterestsResult"
#define kTchillrInterestBaseURI(identifier) [NSString stringWithFormat:@"users/%@/interests",identifier]
#define kTchillrTags @"GetTagsResult"
#warning Change with speciallized Coategory /Concert/etc..
#define kTchillrServiceNameTag @"Musique/Tags"

#define KTchillrInterestIdentifierKey @"identifier"
#define KTchillrInterestIdentifierAddKey @"add"

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

#pragma mark Activities
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

#pragma mark Categories
- (void)startCategoriesRequestWithSuccess:(void (^)(NSArray * categoriesArray))success failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameCategories)]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultCategories = [[NSMutableArray alloc] init];
                                                                                            NSArray *categories = [jsonDict objectForKey:kTchillrTags];
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

#pragma mark Tags for theme
- (void)startTagsRequestForTheme:(TCThemeType) themeType success:(void (^)(NSArray * themeTagsArray))success failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kTchillrServiceURL(kTchillrServiceNameTag)]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSMutableArray * resultTags = [[NSMutableArray alloc] init];
                                                                                            NSArray *tags = [jsonDict objectForKey:kTchillrTags];
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
                                                                                            NSArray *tags = [jsonDict objectForKey:kTchillrInterestsKey];
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

- (void)startUpdateInterestRequestWithIdentifier:(NSNumber*) interestIdentifier add:(BOOL)add success:(void (^)(BOOL  interestUpdateSucceeded))success failure:(void (^)(NSError *error))failure {
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:interestIdentifier,KTchillrInterestIdentifierKey,[NSNumber numberWithBool:add],KTchillrInterestIdentifierAddKey,nil];
    NSURLRequest *interestRequest = [self updateInterestRequestWithParameters:parameters];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:interestRequest
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            success(YES);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

@end
