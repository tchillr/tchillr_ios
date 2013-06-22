//
//  TCServerConstants.h
//  TCServerClient
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#ifndef TCServerClient_TCServerConstants_h
#define TCServerClient_TCServerConstants_h

/* Server  - Base URL */
#define kTCServerBaseURL @"http://tchillrservice.azurewebsites.net/tchillrWCFservice.svc/"
#define kTCServerServiceURL(service) [NSString stringWithFormat:@"%@%@",kTCServerBaseURL,service]

/* Server - URL Suffixes */

/* All Themes */
#define KTCServerThemes @"Themes"
#define kTCServerTags

/* All Activities */
#define kTCServerActivities @"DBActivities"

/* User Activities */
#define kTCServerUserActivities(user,timespan) [NSString stringWithFormat:@"users/%@/activities/timespan/%@",user,timespan]

/* User Interests */
#define kTCServerUserInterests(user) [NSString stringWithFormat:@"users/%@/interests", user]


/* JSON Result Parsing Keys */
#define kTCAllActivitiesKey @"GetFromDBAllActivitiesResult"
#define kTCAllCategoriesKey @"GetDBCategoriesResult"
#define kTCAllThemesKey @"GetThemesResult"
#define kUserInterestsResult @"GetInterestsResult"
#define kPostInterestsResult @"PostInterestsResult"
#define kTCUserActivitiesActivitiesKey @"GetUserActivitiesForDaysResult"
#define kGetTagsResult @"GetTagsResult"
#define KTCInterestIdentifierKey @"identifier"
#define KTCDataKey @"data"



#warning to remove
#define kHeartImage [UIImage imageNamed:@"heart.png"]
#define kHeartImageSelected [UIImage imageNamed:@"heart_selected.png"]

#endif
