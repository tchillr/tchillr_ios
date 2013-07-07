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

/* Login */
#define kTCLogin(UUID) [NSString stringWithFormat:@"login/adduser/%@",UUID]

/* All Themes */
#define KTCServerThemes @"Themes"
#define kTCServerTags

/* All Activities */
#define kTCServerActivities @"DBActivities"

// activities/from/20130706105713/to/20130707235713

/* User Activities */
#define kTCServerUserActivities(user, from, to) [NSString stringWithFormat:@"users/%@/activities/from/%@/to/%@",user, from, to]

/* User Interests */
#define kTCServerUserInterests(user) [NSString stringWithFormat:@"users/%@/interests", user]


/* JSON Result Parsing Keys */
#define kTCAllActivitiesKey @"GetFromDBAllActivitiesResult"
#define kTCAllCategoriesKey @"GetDBCategoriesResult"

#define kUserInterestsResult @"GetInterestsResult"
#define kPostInterestsResult @"PostInterestsResult"
#define kTCUserActivitiesActivitiesKey @"GetUserActivitiesForDaysResult"
#define kGetTagsResult @"GetTagsResult"
#define KTCInterestsIdentifierListKey @"identifiers"
#define KTCDataKey @"data"



#warning to remove
#define kHeartImage [UIImage imageNamed:@"heart.png"]
#define kHeartImageSelected [UIImage imageNamed:@"heart_selected.png"]

#endif
