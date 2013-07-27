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

/* Services - URL Suffixes */

/* Login */
#define kTCLogin(UUID) [NSString stringWithFormat:@"login/adduser/%@",UUID]

/* Themes */
#define KTCServerThemes @"themes"

/* User Activities */
#define kTCServerUserActivities(user, from, to) [NSString stringWithFormat:@"users/%@/activities/from/%@/to/%@",user, from, to]

/* User Activity Attendance */
#define kTCServerUserActivityAttendance(user, activity, attendance) [NSString stringWithFormat:@"users/%@/activities/%@/%@",user, activity, attendance]

/* User Interests */
#define kTCServerUserInterests(user) [NSString stringWithFormat:@"users/%@/interests", user]


/* JSON Parsing Keys */

#define KTCInterestsIdentifierListKey @"identifiers"
#define KTCDataKey @"data"



#endif
