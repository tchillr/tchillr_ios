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

#define kTchillrServiceBaseURL @"http://tchillr.azurewebsites.net/TchillrService.svc/"
#define kTchillrServiceURL(x) [NSString stringWithFormat:@"%@%@",kTchillrServiceBaseURL,x]
#define kTchillrServiceNameActivities @"DBActivities"

#define kTchillrServiceNameCategories @"StaticCategories"
#define kTchillrAllActivitiesKey @"GetFromDBAllActivitiesResult"
#define kTchillrAllCategoriesKey @"GetStaticCategoriesResult"

#define kTchillrInterestsKey @"GetInterestsResult"


#define kTchillrServiceNameTag @"Musique/Tags"


#define USER_NAME_IDENTIFIER @"1"
#warning a changer le 1 correcspondant à l'id du user en base

//#define kTchillrServiceNameAddInterest @
#define kTchillrInterestBaseURI(identifier) [NSString stringWithFormat:@"users/%@/interests",identifier]

#define kTchillrTags @"GetTagsResult"

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
- (void)startTagsRequestForInterestsWithSuccess:(void (^)(NSArray * interestsArray))success failure:(void (^)(NSError *error))failure {
    
    NSString * urlString = kTchillrServiceURL(kTchillrInterestBaseURI(USER_NAME_IDENTIFIER));
    //NSString * urlString2 = kTchillrServiceURL(kTchillrServiceNameTag)
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSDictionary *jsonDict = (NSDictionary *) JSON;
                                                                                            NSArray *tags = [jsonDict objectForKey:kTchillrInterestsKey];
                                                                                            success(tags);
                                                                                        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                                                   NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }
                                         ];
    
    [operation start];
}

/*
- (void)startUserRequestForInterest:(BOOL) interet success:(void (^)(BOOL  interestUpdateSucceeded))success failure:(void (^)(NSError *error))failure {
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
*/

@end
